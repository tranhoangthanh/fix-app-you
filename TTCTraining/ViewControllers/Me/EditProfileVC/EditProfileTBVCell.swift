//
//  EditProfileTBVCell.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class EditProfileTBVCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var lblInfoItem: UILabel!
     @IBOutlet weak var lblInfoUser: UILabel!
    func configCell(_ data: EditProfileMD){
        lblInfoItem.text = data.infoItem.value()
        lblInfoUser.text = data.infoUser.value()
    }
    
}
