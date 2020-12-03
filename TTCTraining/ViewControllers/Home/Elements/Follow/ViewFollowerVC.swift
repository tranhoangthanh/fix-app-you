//
//  ViewFollowerVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewFollowerVC: UIViewController {

    var userFollow: Follow?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    private var posts = [PostModel]()
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PostedTBVCell", bundle: nil), forCellReuseIdentifier: "PostedTBVCell")
        tableView.delegate = self
        tableView.dataSource = self
        userName.text = userFollow?.name
        startListenningForPost()
        // Do any additional setup after loading the view.
        StorageManager.shared.downloadURL(for: (userFollow?.image!)!, completion: { [weak self] result in
            switch result {
            case .success(let url):
                
                DispatchQueue.main.async {
                    self?.profileImg.sd_setImage(with: url, completed: nil)
                }
                
            case .failure(let error):
                print("failed to get image url: \(error)")
            }
        })
    }

    private func startListenningForPost (){
        var email = userFollow?.image
        email?.removeLast(20)
        email?.removeFirst(7)
        print("emailAfter" + email!)
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email!)
        DatabaseManager.shared.getAllPostsForUser(with: safeEmail, completion: {[weak self] result in
            switch result {
            case .success(let posts):
                guard !posts.isEmpty else {
                    return
                }
                print("post 2: \(posts)")
                DispatchQueue.main.async {
                    self?.posts = posts
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("fail to get post:\(error)")
            }
        })
    }

}
extension ViewFollowerVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Total post: \(posts.count)")
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostedTBVCell", for: indexPath) as! PostedTBVCell
        cell.configCell(posts[indexPath.row])
        print("Cell for row: \(posts[indexPath.row])")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
