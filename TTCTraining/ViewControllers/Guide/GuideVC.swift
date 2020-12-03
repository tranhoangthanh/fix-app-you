//
//  GuideVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SafariServices
struct Section {
    var genre: String!
    var details: [DetailGuide]!
    var expanded: Bool!
    init(genre: String, details: [DetailGuide], expanded: Bool) {
        self.genre = genre
        self.details = details
        self.expanded = expanded
    }
}

class DetailGuide:NSObject {
    var mainImg: UIImage?
    var place: String?
    var price: String?
    var openDate: String?
    var url: String?
    
    init(mainImg: UIImage?, place: String?, price: String?, openDate: String?, url: String?){
        self.mainImg = mainImg
        self.place = place
        self.price = price
        self.openDate = openDate
        self.url = url
    }
}
class GuideVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
    func tongleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.beginUpdates()
        for i in 0 ..< sections[section].details.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    @IBOutlet weak var tableView: UITableView!
    var sections = [
        Section(genre: "🏖 Travel",
                details: [
                    DetailGuide(mainImg: UIImage(named: "travel1"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "travel2"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "travel3"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "travel4"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "travel5"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "travel6"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "travel7"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                ], expanded: false),
        Section(genre: "🌻 Entertainment",
                details: [
                    DetailGuide(mainImg: UIImage(named: "game1"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "game2"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "game3"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "game4"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong")
                ], expanded: false),
        
        Section(genre: "🥂Food & Drink",
                details: [
                    DetailGuide(mainImg: UIImage(named: "food1"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "food4"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "food3"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "food2"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong"),
                    DetailGuide(mainImg: UIImage(named: "food5"), place: "Da Lat", price: "120$-140$", openDate: "Mon-Sat", url: "https://www.foody.vn/ha-noi/food/sang-trong")
                ], expanded: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let nibHomeTableView = UINib.init(nibName: "GuideTBV", bundle: nil)
        self.tableView.register(nibHomeTableView, forCellReuseIdentifier: "CellGuide")
        //
        // Do any additional setup after loading the view.
    }
    func showTutorial(_ url: String) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
        let vc = SFSafariViewController(url: URL(string: url)!, configuration: config)
            present(vc, animated: true)
        }
    
    //Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].details.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.sections[indexPath.section].expanded) {
            return 400
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellGuide", for: indexPath) as! GuideTBV
        cell.configCell(sections[indexPath.section].details[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(sections[indexPath.section].details[indexPath.row].url!)
    }
    
}
