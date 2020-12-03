//
//  SettingVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
class SettingVC: UIViewController {
    var lstSetting = SettingMD.initSetting()
    var lstTitleSection = ["ACCOUNT", "GENERAL","SUPPORT","ABOUT"]
    @IBOutlet weak var settingTableView: UITableView!
    @IBAction func btnBackAction(_ sender: Any) {
        createAnimated(self: self)
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    func initData(){
    }
    
    func initUI(){
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(UINib(nibName: "SettingTBVCell", bundle: nil), forCellReuseIdentifier: "SettingTBVCell")
    }
}

// MARK: - TableViewDelegates and datasources
extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return lstSetting.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return lstTitleSection[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstSetting[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: "SettingTBVCell", for: indexPath) as? SettingTBVCell
        cell?.configCell(lstSetting[indexPath.section][indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [self.settingTableView!.numberOfSections - 1, 5] {
            let actionSheet = UIAlertController(title: "", message: "Do you want to log out? ", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
                // Log out FB
                FBSDKLoginKit.LoginManager().logOut()
                // Log out Google
                GIDSignIn.sharedInstance()?.signOut()
                do {
                    try FirebaseAuth.Auth.auth().signOut()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginVC = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true, completion: nil)
                }
                catch {
                    self.alertError(message: "Fail to logout")
                }
                
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            present(actionSheet, animated: true, completion: nil)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath:IndexPath) -> CGFloat {
        return 40
    }
}
