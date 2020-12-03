//
//  AddFriendCollectionViewCell.swift
//  TTCTraining
//
//  Created by Apple on 10/24/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AddFriendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnFollow: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ data: Follow){
        // config UI
        btnAdd.cornerRadius(5)
        btnFollow.cornerRadius(5)
        // Config Data
        StorageManager.shared.downloadURL(for: data.image!, completion: { [weak self] result in
            switch result {
            case .success(let url):
                
                DispatchQueue.main.async {
                    self?.profileImg.sd_setImage(with: url, completed: nil)
                }
                
            case .failure(let error):
                print("failed to get image url: \(error)")
            }
        })
        job.text = "JOB"
        name.text = data.name
    }
}
