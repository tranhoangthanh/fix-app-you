//
//  AboutMeViewController.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/9/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import SDWebImage
class AboutMeViewController: UIViewController {
    var lstPost = PostedMD.initPost()
    private var posts = [PostModel]()
    @IBOutlet weak var countFollowings: UILabel!
    @IBOutlet weak var countFollowers: UILabel!
    @IBOutlet weak var countPosts: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postedTableView: UITableView!
    @IBOutlet weak var postTableViewHeight: NSLayoutConstraint!
    @IBAction func createPostGestureAction(_ sender: Any) {
        let createPostVC = CreatePostVC(nibName: "CreatePostVC", bundle: nil)
        createPostVC.modalPresentationStyle = .fullScreen
        self.present(createPostVC, animated: true, completion: nil)
    }
    @IBAction func btnEditProfileAction(_ sender: Any) {
        let editProfileVC = EditProfileVC(nibName: "EditProfileVC", bundle: nil)
        editProfileVC.modalPresentationStyle = .fullScreen
        createAnimated(self: self)
        self.present(editProfileVC, animated: false, completion: nil)
    }
    @IBAction func btnSettingAction(_ sender: Any) {
        let settingVC = SettingVC(nibName: "SettingVC", bundle: nil)
        settingVC.modalPresentationStyle = .fullScreen
        createAnimated(self: self)
        self.present(settingVC, animated: false, completion: nil)
    }
    
    @IBAction func btnListAllFollowings(_ sender: Any) {
        let vc = FollowingsVC(nibName: "FollowingsVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnListAllFollowers(_ sender: Any) {
        let vc = FollowersVC(nibName: "FollowersVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        startListenningForPost()

    }
    func initUI(){
        postedTableView.delegate = self
        postedTableView.dataSource = self
        postedTableView.register(UINib(nibName: "PostedTBVCell", bundle: nil), forCellReuseIdentifier: "PostedTBVCell")
       
        setImageProfile(profileImage: profileImage)
        setImageProfile(profileImage: profileImg)
        getCount()
        userName.text = UserDefaults.standard.value(forKey: "name") as? String
    }
    private func startListenningForPost (){
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        DatabaseManager.shared.getAllPostsForUser(with: safeEmail, completion: {[weak self] result in
            switch result {
            case .success(let posts):
                guard !posts.isEmpty else {
                    return
                }
                print("post 2: \(posts)")
                DispatchQueue.main.async {
                    self?.posts = posts
                    self?.postTableViewHeight.constant = CGFloat(posts.count * 500)
                    self?.postedTableView.reloadData()
                }
            case .failure(let error):
                print("fail to get post:\(error)")
            }
        })
    }
    func getCount() {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String
        else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        DatabaseManager.shared.getAllFollowings(with: safeEmail, completion: {[weak self] result in
            switch result {
            case .success(let allFollowings):
                self!.countFollowings.text = String(allFollowings.count)
            case .failure(let error):
                self!.countFollowings.text = "0"
                print("Failed to get usres: \(error)")
            }})
        DatabaseManager.shared.getAllFollowers(with: safeEmail, completion: {[weak self] result in
            switch result {
            case .success(let allFollowers):
                self!.countFollowers.text = String(allFollowers.count)
                print("allFollowers.count: \(allFollowers.count)")
            case .failure( _):
                self!.countFollowers.text = "0"
            }})
        DatabaseManager.shared.getAllPostsForUser(with: safeEmail, completion: {[weak self] result in
            switch result {
            case .success(let allPosts):
                self!.countPosts.text = String(allPosts.count)
            case .failure(let error):
                self!.countPosts.text = "0"
                print("Failed to get usres: \(error)")
            }})
    }
}

// MARK: - TableViewDelegates and datasources
extension AboutMeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func showAlertCell() {
        let alertController = UIAlertController(title: "Modify", message: "Do you want to delete or update post?", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (_) in
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Total post: \(posts.count)")
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postedTableView.dequeueReusableCell(withIdentifier: "PostedTBVCell", for: indexPath) as! PostedTBVCell
        cell.configCell(posts[indexPath.row])
        cell.delegate = self
        print("Cell for row: \(posts[indexPath.row])")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("posthii")
//
//        print("CLick post")
//    }
}


extension AboutMeViewController : ShowAlertCellTBVDelagate  {
    func showAlert() {
        self.showAlertCell()
    }
}
