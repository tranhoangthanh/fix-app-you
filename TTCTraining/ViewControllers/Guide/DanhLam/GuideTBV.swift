//
//  GuideTBV.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/25/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class GuideTBV: UITableViewCell {

    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var openDate: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configCell(_ data: DetailGuide){
        // Config Data
        mainImg.image = data.mainImg
        price.text = data.price
        place.text = data.place
        openDate.text = data.openDate
    }
}
