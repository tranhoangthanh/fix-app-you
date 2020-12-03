//
//  FollowersVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/30/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class FollowersVC: UIViewController {

    private var follows = [Follow]()
    private var followings = [Follow]()
    public var fromController: String?

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
        getAllFollowers()
    }

    // get All followers
    func getAllFollowers() {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String
        else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        DatabaseManager.shared.getAllFollowers(with: safeEmail, completion: {[weak self] result in
            switch result {
            case .success(let allFollowings):
                self!.follows = allFollowings
                print("self!.followings: \(self!.follows)")
                self!.tableView.reloadData()
            case .failure(let error):
                print("Failed to get usres: \(error)")
            }})
    }
}
extension FollowersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowTBV", for: indexPath) as! FollowTBV
        cell.followEmail = follows[indexPath.row].userRecieveRequestEmail
        cell.followName = follows[indexPath.row].name
        cell.configCell(follows[indexPath.row])
        return cell
    }
}
