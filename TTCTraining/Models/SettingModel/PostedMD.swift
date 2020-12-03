//
//  PostedMD.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/14/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class PostedMD: NSObject {
    var placeCheckIn: String?
    var contentPost: String?
    var imgPost: String?
    init(placeCheckIn: String?, contentPost: String?, imgPost: String?) {
        self.placeCheckIn = placeCheckIn
        self.contentPost = contentPost
        self.imgPost = imgPost
    }
    
    func clone() -> PostedMD{
        return PostedMD(placeCheckIn: self.placeCheckIn, contentPost: self.contentPost, imgPost: self.imgPost)
    }
    static func initPost() -> [PostedMD]{
        return [PostedMD(placeCheckIn: "Da Lat", contentPost: "iOS 13 lets us use icons from a range of over 1500 designed by Apple, all of which come in a variety of weights and sizes. These icons form part of new UIImage API, and they are vector-based so you can us them at a range of sizes without loss of quality.", imgPost: "daLat"),
                PostedMD(placeCheckIn: "Da Lat", contentPost: "iOS 13 lets us use icons from a range of over 1500 designed by Apple, all of which come in a variety of weights and sizes. These icons form part of new UIImage API, and they are vector-based so you can us them at a range of sizes without loss of quality.", imgPost: "daLat"),
                PostedMD(placeCheckIn: "Da Lat", contentPost: "iOS 13 lets us use icons from a range of over 1500 designed by Apple, all of which come in a variety of weights and sizes. These icons form part of new UIImage API, and they are vector-based so you can us them at a range of sizes without loss of quality.", imgPost: "daLat")
            
        ]
    }
}
