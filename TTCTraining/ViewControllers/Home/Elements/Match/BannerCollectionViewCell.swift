//
//  BannerCollectionViewCell.swift
//  TTCTraining
//
//  Created by Apple on 10/24/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func configCell(_ data: PostModel){
        // config UI
        // Config Data
        mainImg.sd_setImage(with: URL(string: "\(data.postImageURL)")!, completed: nil)
        position.text = "Viet Nam"
        place.text = data.contentPost
        title.text = data.userPostName
        time.text = "10h"
        date.text = data.postDate
    }

}
