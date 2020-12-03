//
//  SettingMD.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
class SettingMD: NSObject{
    var imgSettingURL: UIImage?
    var desSetting: String?
    init(imgSettingURL: UIImage?, desSetting: String?) {
        self.imgSettingURL = imgSettingURL
        self.desSetting = desSetting
    }
    
    func clone() -> SettingMD{
        return SettingMD(imgSettingURL: self.imgSettingURL, desSetting: self.desSetting)
    }
    static func initSetting() -> [[SettingMD]]{
        return [[SettingMD(imgSettingURL: UIImage(systemName: "person.circle"), desSetting: "Manage my account"),
                SettingMD(imgSettingURL: UIImage(systemName: "lock.doc"), desSetting: "Privacy and safety"),
                SettingMD(imgSettingURL: UIImage(systemName: "lock.shield"), desSetting: "Security"),
                SettingMD(imgSettingURL: UIImage(systemName: "scale.3d"), desSetting: "Balance"),
                SettingMD(imgSettingURL: UIImage(systemName: "doc.richtext"), desSetting: "Content preferences"),
                SettingMD(imgSettingURL: UIImage(systemName: "arrowshape.turn.up.right.circle"), desSetting: "Share profile")],

                [SettingMD(imgSettingURL: UIImage(systemName: "bell.circle"), desSetting: "Push notification"),
                SettingMD(imgSettingURL: UIImage(systemName: "speaker.zzz"), desSetting: "Language"),
                SettingMD(imgSettingURL: UIImage(systemName: "figure.wave.circle"), desSetting: "Accessibility"),
                SettingMD(imgSettingURL: UIImage(systemName: "thermometer.sun"), desSetting: "Data Saver"),
            ],

                [SettingMD(imgSettingURL: UIImage(systemName: "pencil.circle"), desSetting: "Report a problem"),
                SettingMD(imgSettingURL: UIImage(systemName: "questionmark.diamond"), desSetting: "Help Center"),
                SettingMD(imgSettingURL: UIImage(systemName: "rosette"), desSetting: "Safety Center")],

                [SettingMD(imgSettingURL: UIImage(systemName: "doc.text"), desSetting: "Term of Use"),
                SettingMD(imgSettingURL: UIImage(systemName: "book.circle"), desSetting: "Community Guidelines"),
                SettingMD(imgSettingURL: UIImage(systemName: "doc.text"), desSetting: "Privacy Policy"),
                SettingMD(imgSettingURL: UIImage(systemName: "c.circle"), desSetting: "Copyright Policy"),
                SettingMD(imgSettingURL: UIImage(systemName: "person.badge.plus"), desSetting: "Add account"),
                SettingMD(imgSettingURL: UIImage(systemName: "person.badge.minus"), desSetting: "Log out"),
            ]
                                                                               
                                                                               
        ]
    }
}
