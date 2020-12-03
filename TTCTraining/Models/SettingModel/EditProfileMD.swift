//
//  EditProfileMD.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class EditProfileMD: NSObject{
    var infoItem: String?
    var infoUser: String?
    init(infoItem: String?, infoUser: String?) {
        self.infoItem = infoItem
        self.infoUser = infoUser
    }
    
    func clone() -> EditProfileMD{
        return EditProfileMD(infoItem: self.infoItem, infoUser: self.infoUser)
    }
    static func initEditProfile() -> [EditProfileMD]{
        return [EditProfileMD(infoItem: "Name", infoUser: "Tâm Tâm 4199"),
                EditProfileMD(infoItem: "Username", infoUser: "Hana@0098"),
                EditProfileMD(infoItem: "Bio", infoUser: "Add a bio to your profile"),
                EditProfileMD(infoItem: "Curent City", infoUser: "Add curent city to your profile"),
                EditProfileMD(infoItem: "Workplace", infoUser: "Add workplace to your profile"),
                EditProfileMD(infoItem: "Education", infoUser: "Add education to your profile"),
                EditProfileMD(infoItem: "Hometown", infoUser: "Add hometown to your profile"),
                EditProfileMD(infoItem: "Hobby", infoUser: "Add hobby to your profile"),
                EditProfileMD(infoItem: "Twitter", infoUser: "Add Twitter to your profile"),
                EditProfileMD(infoItem: "Facebook", infoUser: "Add Facebook to your profile"),
                EditProfileMD(infoItem: "Instagram", infoUser: "Add Instagram to your profile")
        ]
    }
}
