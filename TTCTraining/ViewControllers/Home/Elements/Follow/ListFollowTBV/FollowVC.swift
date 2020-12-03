//
//  AddFriendVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/25/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
class FollowVC: UIViewController {
    private var follows = [Follow]()
    private var followings = [Follow]()

    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let cell = UINib.init(nibName: "FollowTBV", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: "FollowTBV")
        tableView.delegate = self
        tableView.dataSource = self
        initData()
        
        // Do any additional setup after loading the view.
    }
    func initData() {
        getAllFollowUser()
    }
    
    func getAllFollowUser() {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String
        else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        DatabaseManager.shared.getAllUnFollows(with: safeEmail, completion: { [weak self] result in
                switch result {
                case .success(let usersCollection):
                    self!.follows = usersCollection
                    print("follow111: \(self!.follows)")
                    DatabaseManager.shared.getAllFollowings(with: safeEmail, completion: { [weak self] result in
                            switch result {
                            case .success(let allFollowings):
                                self?.followings = allFollowings
                                
                                var listIndex = [Int]()
                                for follow in allFollowings {
                                    for i in 0 ..< usersCollection.count {
                                        if follow.userRecieveRequestEmail == usersCollection[i].userRecieveRequestEmail {
                                            listIndex.append(i)
                                        }
                                    }
                                }
                                self?.follows = usersCollection
                                    .enumerated()
                                    .filter { !listIndex.contains($0.offset) }
                                    .map { $0.element }
                                print("follow: \(self?.follows)")
                                self?.tableView.reloadData()
                                
                            case .failure( _):
                                self!.tableView.reloadData()

                                print("follow2: \(self!.follows)")
                                return
                            }
                        })
                case .failure(let error):
                    print("Failed to get usres: \(error)")
                }
            
            })
        }
}
extension FollowVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowTBV", for: indexPath) as! FollowTBV
        cell.followEmail = follows[indexPath.row].userRecieveRequestEmail
        cell.followName = follows[indexPath.row].name
        cell.configCell(follows[indexPath.row])
        cell.btnView.addTarget(self, action: #selector(btnViewTapped), for: .touchUpInside)
        return cell
    }
    
    @objc func btnViewTapped(sender:UIButton){
        let vc = ViewFollowerVC(nibName: "ViewFollowerVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

struct Follow {
    var image: String?
    var name: String?
    var userSendRequestEmail: String?
    var userRecieveRequestEmail: String?
    
}
