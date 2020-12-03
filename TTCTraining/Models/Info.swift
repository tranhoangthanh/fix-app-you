//
//  Info.swift
//  TTCTraining
//
//  Created by Apple on 10/23/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit
class Info:NSObject {
    var mainImg: UIImage?
    var profileImg: UIImage?
    var title: String?
    var position: String?
    var place: String?
    var name: String?
    var time: String?
    var date: String?
    var job: String?
    var tickImg: UIImage?
    
    init(mainImg: UIImage?, profileImg: UIImage?, title: String?, position: String?, place: String?, name: String?, time: String?, date: String?, job: String?, tickImg:UIImage?){
        self.mainImg = mainImg
        self.profileImg = profileImg
        self.title = title
        self.position = position
        self.place = place
        self.name = name
        self.time = time
        self.date = date
        self.job = job
        self.tickImg = tickImg
    }
    static func initInfo() -> [Info] {
        return [Info(mainImg: UIImage(named: "banaHill"), profileImg: UIImage(named: "suli"), title: "Who wanna join with me in Ba na", position: "Da Nang", place: "Bana Hill", name: "Su Li", time: "09:00 AM", date: "21/11/2019", job: "Accounter", tickImg: UIImage(named: "checked")),
                Info(mainImg: UIImage(named: "daLat"), profileImg: UIImage(named: "lily"), title: "So cool in dalat?", position: "Da La", place: "Dalat", name: "LiLy Maymac", time: "11:00 AM", date: "07/11/2010", job: "Sinh Viên", tickImg: UIImage(named: "cancel")),
                Info(mainImg: UIImage(named: "langBac"), profileImg: UIImage(named: "duongTu"), title: "HochiMinh ville avec les amis", position: "Ha Noi", place: "Ho Chi Minh", name: "Duong Tu", time: "02:00 PM", date: "21/12/2019", job: "Quản lí", tickImg: UIImage(named: "checked")),
                Info(mainImg: UIImage(named: "muCangChai"), profileImg: UIImage(named: "huongGiang"), title: "Search friend travel with me on Sunday", position: "TayBac", place: "Mu Cang Chai", name: "Huong Giang", time: "08:00 AM", date: "04/12/2019", job: "Bussiness", tickImg: UIImage(named: "checked")),
                Info(mainImg: UIImage(named: "phuQuoc"), profileImg: UIImage(named: "kendall"), title: "Looking for friend in PhuQuoc", position: "Phu Quoc", place: "Phu Quoc", name: "Kendall", time: "09:00 AM", date: "21/02/2020", job: "Student", tickImg: UIImage(named: "cancel")),
                Info(mainImg: UIImage(named: "banaHill"), profileImg: UIImage(named: "suli"), title: "Who wanna join with me in Ba na", position: "Da Nang", place: "Bana Hill", name: "Su Li", time: "09:00 AM", date: "21/11/2019", job: "Accounter", tickImg: UIImage(named: "checked")),
                        Info(mainImg: UIImage(named: "daLat"), profileImg: UIImage(named: "lily"), title: "So cool in dalat?", position: "Da La", place: "Dalat", name: "LiLy Maymac", time: "11:00 AM", date: "07/11/2010", job: "Sinh Viên", tickImg: UIImage(named: "cancel")),
                        Info(mainImg: UIImage(named: "langBac"), profileImg: UIImage(named: "duongTu"), title: "HochiMinh ville avec les amis", position: "Ha Noi", place: "Ho Chi Minh", name: "Duong Tu", time: "02:00 PM", date: "21/12/2019", job: "Quản lí", tickImg: UIImage(named: "checked")),
                        Info(mainImg: UIImage(named: "muCangChai"), profileImg: UIImage(named: "huongGiang"), title: "Search friend travel with me on Sunday", position: "TayBac", place: "Mu Cang Chai", name: "Huong Giang", time: "08:00 AM", date: "04/12/2019", job: "Bussiness", tickImg: UIImage(named: "checked")),
                        Info(mainImg: UIImage(named: "phuQuoc"), profileImg: UIImage(named: "kendall"), title: "Looking for friend in PhuQuoc", position: "Phu Quoc", place: "Phu Quoc", name: "Kendall", time: "09:00 AM", date: "21/02/2020", job: "Student", tickImg: UIImage(named: "cancel")),
                        Info(mainImg: UIImage(named: "banaHill"), profileImg: UIImage(named: "suli"), title: "Who wanna join with me in Ba na", position: "Da Nang", place: "Bana Hill", name: "Su Li", time: "09:00 AM", date: "21/11/2019", job: "Accounter", tickImg: UIImage(named: "checked")),
                                Info(mainImg: UIImage(named: "daLat"), profileImg: UIImage(named: "lily"), title: "So cool in dalat?", position: "Da La", place: "Dalat", name: "LiLy Maymac", time: "11:00 AM", date: "07/11/2010", job: "Sinh Viên", tickImg: UIImage(named: "cancel")),
                                Info(mainImg: UIImage(named: "langBac"), profileImg: UIImage(named: "duongTu"), title: "HochiMinh ville avec les amis", position: "Ha Noi", place: "Ho Chi Minh", name: "Duong Tu", time: "02:00 PM", date: "21/12/2019", job: "Quản lí", tickImg: UIImage(named: "checked")),
                                Info(mainImg: UIImage(named: "muCangChai"), profileImg: UIImage(named: "huongGiang"), title: "Search friend travel with me on Sunday", position: "TayBac", place: "Mu Cang Chai", name: "Huong Giang", time: "08:00 AM", date: "04/12/2019", job: "Bussiness", tickImg: UIImage(named: "checked")),
                                Info(mainImg: UIImage(named: "phuQuoc"), profileImg: UIImage(named: "kendall"), title: "Looking for friend in PhuQuoc", position: "Phu Quoc", place: "Phu Quoc", name: "Kendall", time: "09:00 AM", date: "21/02/2020", job: "Student", tickImg: UIImage(named: "cancel")),
        ]
    }
    
}
//class SectionClass {
//    var genre: String!
//    var movies: [Info]!
//    var expanded: Bool!
//    init(genre: String, movies: [Info], expanded: Bool) {
//        self.genre = genre
//        self.movies = movies
//        self.expanded = expanded
//    }
//    
//    static func initInfo1() -> [SectionClass] {
//        return [
//            SectionClass(genre: "👻 Danh Lam Thắng Cảnh", movies: [Info(mainImg: UIImage(named: "banaHill"), profileImg: UIImage(named: "suli"), title: "Ai đi bà nà không?", position: "Đà Nẵng", place: "Bà nà Hill", name: "Su Li", time: "09:00 AM", date: "21/11/2019", job: "Kế toán", tickImg: UIImage(named: "checked")),
//                                                                    Info(mainImg: UIImage(named: "daLat"), profileImg: UIImage(named: "lily"), title: "Đà lạt lạnh quá?", position: "Đà Lạt", place: "Lâm đồng, Đà Lạt", name: "LiLy Maymac", time: "11:00 AM", date: "07/11/2010", job: "Sinh Viên", tickImg: UIImage(named: "cancel")),
//                                                                    Info(mainImg: UIImage(named: "langBac"), profileImg: UIImage(named: "duongTu"), title: "Lăng bác cùng đồng đội", position: "Hà Nội", place: "Lăng bác hồ", name: "Dương Tử", time: "02:00 PM", date: "21/12/2019", job: "Quản lí", tickImg: UIImage(named: "checked")),
//                                                                    Info(mainImg: UIImage(named: "muCangChai"), profileImg: UIImage(named: "huongGiang"), title: "Tìm bạn Việt Nam dẫn đi chơi", position: "Tây bắc", place: "Mù Cang Chải", name: "Hương Giang", time: "08:00 AM", date: "04/12/2019", job: "Kinh doanh tự do", tickImg: UIImage(named: "checked"))
//            ], expanded: false),
//            SectionClass(genre: "👻 Di Tích Lịch Sử", movies: [Info(mainImg: UIImage(named: "daLat"), profileImg: UIImage(named: "lily"), title: "Đà lạt lạnh quá?", position: "Đà Lạt", place: "Lâm đồng, Đà Lạt", name: "LiLy Maymac", time: "11:00 AM", date: "07/11/2010", job: "Sinh Viên", tickImg: UIImage(named: "cancel")),Info(mainImg: UIImage(named: "daLat"), profileImg: UIImage(named: "lily"), title: "Đà lạt lạnh quá?", position: "Đà Lạt", place: "Lâm đồng, Đà Lạt", name: "LiLy Maymac", time: "11:00 AM", date: "07/11/2010", job: "Sinh Viên", tickImg: UIImage(named: "cancel"))], expanded: false),
//            SectionClass(genre: "👻 Địa Điểm Ăn Uống", movies: [Info(mainImg: UIImage(named: "daLat"), profileImg: UIImage(named: "lily"), title: "Đà lạt lạnh quá?", position: "Đà Lạt", place: "Lâm đồng, Đà Lạt", name: "LiLy Maymac", time: "11:00 AM", date: "07/11/2010", job: "Sinh Viên", tickImg: UIImage(named: "cancel")),Info(mainImg: UIImage(named: "daLat"), profileImg: UIImage(named: "lily"), title: "Đà lạt lạnh quá?", position: "Đà Lạt", place: "Lâm đồng, Đà Lạt", name: "LiLy Maymac", time: "11:00 AM", date: "07/11/2010", job: "Sinh Viên", tickImg: UIImage(named: "cancel"))], expanded: false),
//        ]
//    }
//}
