//
//  FollowTBV.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/25/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FollowTBV: UITableViewCell {    
    @IBOutlet weak var btnView: TouchEffectButton!
    private let database = Database.database().reference()
    var followEmail: String?
    var followName: String?
    @IBOutlet weak var btnFollow: TouchEffectButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnViewAction(_ sender: Any) {
        let vc = ViewFollowerVC(nibName: "ViewFollowerVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        print("Click view")
    }
    
    @IBAction func btnFollowAction(_ sender: Any) {
//        click = !click
//        if click == false {
//            unFollow(userRecieveUnfollowEmail: followEmail!, completion: {[self] success in
//                if success {
//                    btnFollow.setTitle("Follow", for: .normal)
//                    print("UnFollow sent")
//                }
//                else {
//                    print("faield to UnFollow")
//
//                }
//            })
//        }
//        else {
//
//
//        }
        addFollow(userRecieveRequestEmail: followEmail!, userRecieveRequestName: followName!, completion: { [self] success in
            if success {
//                btnFollow.setTitle("Following ✅", for: .normal)
                print("Follow sent")
                
            }
            else {
                print("faield to Follow")
                
            }
        })
    }
    
    func configCell(_ data: Follow) {
        self.name.text = data.name
        StorageManager.shared.downloadURL(for: data.image!, completion: { [weak self] result in
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
    
    private func addFollow(userRecieveRequestEmail: String, userRecieveRequestName: String , completion: @escaping (Bool) -> Void)  {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String,
              let currentName = UserDefaults.standard.value(forKey: "name") as? String
        else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        
        database.child("\(safeEmail)/followings").observeSingleEvent(of: .value, with: { snapshot in
            if var following = snapshot.value as? [[String: String]] {
                // append to user dictionary
                
                let newElement = [
                    "email": userRecieveRequestEmail,
                    "name": userRecieveRequestName
                ]
                following.append(newElement)
                
                self.database.child("\(safeEmail)/followings").setValue(following, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    
                    completion(true)
                })
            }
            else {
                // create that array
                let following: [[String: String]] = [
                    [
                        "email": userRecieveRequestEmail,
                        "name": userRecieveRequestName
                    ]
                ]
                
                self.database.child("\(safeEmail)/followings").setValue(following, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                })
            }
        })
        
        database.child("\(userRecieveRequestEmail)/followers").observeSingleEvent(of: .value, with: { snapshot in
            if var follower = snapshot.value as? [[String: String]] {
                // append to user dictionary
                
                let newElement = [
                    "email": safeEmail,
                    "name": currentName
                ]
                follower.append(newElement)
                
                self.database.child("\(userRecieveRequestEmail)/followers").setValue(follower, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    
                    completion(true)
                })
            }
            else {
                // create that array
                let newCollection: [[String: String]] = [
                    [
                        "email": safeEmail,
                        "name": currentName
                    ]
                ]
                
                self.database.child("\(userRecieveRequestEmail)/followers").setValue(newCollection, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                })
            }
        })
        
    }

//    private func unFollow(userRecieveUnfollowEmail: String , completion: @escaping (Bool) -> Void)  {
//        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
//            return
//        }
//        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
//
//        // current user unfollow-> delete
//        database.child("\(safeEmail)/followings").observeSingleEvent(of: .value) { snapshot in
//            if var followings = snapshot.value as? [[String: Any]] {
//                var positionToRemove = 0
//                for following in followings {
//                    if let email = following["email"] as? String,
//                       email == userRecieveUnfollowEmail {
//                        print("found user follow to delete")
//                        break
//                    }
//                    positionToRemove += 1
//                }
//                followings.remove(at: positionToRemove)
//                self.database.child("\(safeEmail)/followings").setValue(followings, withCompletionBlock: { error, _  in
//                    guard error == nil else {
//                        completion(false)
//                        print("faield to delete following")
//                        return
//                    }
//                    print("deleted following")
//                    completion(true)
//                })
//            }
//        }
//        // current user unfollow
//        database.child("\(userRecieveUnfollowEmail)/followers").observeSingleEvent(of: .value) { snapshot in
//            if var followers = snapshot.value as? [[String: Any]] {
//                var positionRemove = 0
//                for follower in followers {
//                    if let email = follower["email"] as? String,
//                       email == safeEmail {
//                        print("found user follower to delete")
//                        break
//                    }
//                    positionRemove += 1
//                }
//                followers.remove(at: positionRemove)
//                self.database.child("\(userRecieveUnfollowEmail)/followers").setValue(followers, withCompletionBlock: { error, _  in
//                    guard error == nil else {
//                        completion(false)
//                        print("faield to delete follower")
//                        return
//                    }
//                    print("deleted follower")
//                    completion(true)
//                })
//            }
//        }
//
//    }
}

