//
//  SettingTBVCell.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class SettingTBVCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBOutlet weak var imgSetting: UIImageView!
    @IBOutlet weak var lblDesSetting: UILabel!
    
    func configCell(_ data: SettingMD){
        imgSetting.image = data.imgSettingURL
        lblDesSetting.text = data.desSetting.value()
    }
    
}
