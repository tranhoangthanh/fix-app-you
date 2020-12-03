//
//  UnfollowTBV.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/30/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
class UnfollowTBV: UITableViewCell {

    private let database = Database.database().reference()
    var followEmail: String?
    var followName: String?
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

    @IBAction func btnUnFollowAction(_ sender: Any) {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)

        // current user unfollow-> delete
        database.child("\(safeEmail)/followings").observeSingleEvent(of: .value) { snapshot in
            if var followings = snapshot.value as? [[String: Any]] {
                var positionToRemove = 0
                for following in followings {
                    if let email = following["email"] as? String,
                       email == self.followEmail {
                        print("found user follow to delete")
                        break
                    }
                    positionToRemove += 1
                }
                followings.remove(at: positionToRemove)
                self.database.child("\(safeEmail)/followings").setValue(followings, withCompletionBlock: { error, _  in
                    guard error == nil else {
                        print("faield to delete following")
                        return
                    }
                    print("deleted following")
               })
            }
        }
        // current user unfollow
        database.child("\(followEmail)/followers").observeSingleEvent(of: .value) { snapshot in
            if var followers = snapshot.value as? [[String: Any]] {
                var positionRemove = 0
                for follower in followers {
                    if let email = follower["email"] as? String,
                       email == safeEmail {
                        print("found user follower to delete")
                        break
                    }
                    positionRemove += 1
                }
                followers.remove(at: positionRemove)
                self.database.child("\(self.followEmail)/followers").setValue(followers, withCompletionBlock: { error, _  in
                    guard error == nil else {
                        print("faield to delete follower")
                        return
                    }
                    print("deleted follower")
                })
            }
        }

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
    
        
}

