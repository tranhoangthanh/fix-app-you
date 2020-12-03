//
//  NotiVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class NotiVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var listInfo:[Info] = [];
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        listInfo = Info.initInfo()
        let nib = UINib.init(nibName: "NotiTBVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NotiTBVCell")
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotiTBVCell", for: indexPath) as! NotiTBVCell
        cell.configCell(listInfo[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = listInfo.count - 1
        if indexPath.row == lastElement {
            loadMoreData()
        }
    }
    func loadMoreData(){
        for i in 0..<5 {
            let lastItem = listInfo.last!
            let newItem = listInfo[i]
            listInfo.append(newItem)
        }
        tableView.reloadData()
    }
    

}
