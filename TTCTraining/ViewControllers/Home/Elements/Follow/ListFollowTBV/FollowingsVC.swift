//
//  FollowingsVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/30/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class FollowingsVC: UIViewController {
    private var follows = [Follow]()
    private var followings = [Follow]()
    public var fromController: String?

    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let cell = UINib.init(nibName: "UnfollowTBV", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: "UnfollowTBV")
        tableView.delegate = self
        tableView.dataSource = self
       initData()
        
        // Do any additional setup after loading the view.
    }
    
    func initData() {
        getAllFollowings2()
    }
    // get All followings
    func getAllFollowings2() {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String
        else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        DatabaseManager.shared.getAllFollowings2(with: safeEmail, completion: {[weak self] result in
            switch result {
            case .success(let allFollowings):
                self?.follows = allFollowings
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to get usres: \(error)")
            }})
    }
}
extension FollowingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnfollowTBV", for: indexPath) as! UnfollowTBV
        cell.followEmail = follows[indexPath.row].userRecieveRequestEmail
        cell.followName = follows[indexPath.row].name
        cell.configCell(follows[indexPath.row])
        return cell
    }
}
