//
//  ExpandableHeaderView.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func tongleSection(header: ExpandableHeaderView, section: Int)
}
class ExpandableHeaderView: UITableViewHeaderFooterView {
    var delegate : ExpandableHeaderViewDelegate?
    var section: Int!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    @objc func selectHeaderAction(gestureRecognizer: UIGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.tongleSection(header: self, section: cell.section)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.black
        self.contentView.frame.size.height = 40
        self.contentView.frame.origin.x = 20
        self.contentView.frame.size.width = self.contentView.frame.size.width - 40
        self.contentView.cornerRadius(5)
    }
}

//
//import UIKit
//struct Section {
//    var genre: String!
//    var movies: [String]!
//    var expanded: Bool!
//    init(genre: String, movies: [String], expanded: Bool) {
//        self.genre = genre
//        self.movies = movies
//        self.expanded = expanded
//    }
//}
//class GuideVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
//    func tongleSection(header: ExpandableHeaderView, section: Int) {
//        sections[section].expanded = !sections[section].expanded
//        tableView.beginUpdates()
//        for i in 0 ..< sections[section].movies.count {
//            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
//        }
//        tableView.endUpdates()
//    }
//
//    @IBOutlet weak var tableView: UITableView!
//    var sections = [
//        Section(genre: "👻 Animation", movies: ["Lion King", "hihi"], expanded: false),
//        Section(genre: "👻 Cartoon", movies: ["Cartoon King", "Cartoon", "Cartoon"], expanded: false),
//        Section(genre: "👻 Cute", movies: ["Cute King", "Cute","Cute2", "Cute3"], expanded: false),
//    ]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.delegate = self
//        tableView.dataSource = self
////        let nibHomeTableView = UINib.init(nibName: "HomeTableViewCell", bundle: nil)
////        self.tableView.register(nibHomeTableView, forCellReuseIdentifier: "Cell")
////
//        // Do any additional setup after loading the view.
//    }
//
//    //Table View
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].movies.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if(self.sections[indexPath.section].expanded) {
//            return 44
//        }
//        else {
//            return 0
//        }
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = ExpandableHeaderView()
//        header.customInit(title: sections[section].genre, section: section, delegate: self)
//        return header
//    }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CellGuide", for: indexPath)
//            cell.textLabel?.text = sections[indexPath.section].movies[indexPath.row]
//            return cell
//        }
//
//}
//
//
