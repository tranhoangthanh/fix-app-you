//
//  PostedTBVCell.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/14/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

protocol ShowAlertCellTBVDelagate : class {
    func showAlert()
}
class PostedTBVCell: UITableViewCell {
    var likeImage: Bool = false
    var valueLike: String = "10"
    weak var delegate : ShowAlertCellTBVDelagate?
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var currentName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var countLike: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        countLike.setTitle(valueLike, for: .normal)
    }

    @IBAction func buttShowAlert(_ sender: Any) {
           delegate?.showAlert()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnCommentAction(_ sender: Any) {
        print("true cmt")
    }
    
    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var contentPost: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBAction func btnLikeAction(_ sender: Any) {
        print("true tru1e")
       likeImage = !likeImage
        if likeImage == true {
             btnLike.setImage(UIImage(named: "heart_red"), for: .normal)
            valueLike = String((valueLike as NSString).integerValue + 1)
            countLike.setTitle(valueLike, for: .normal)

         } else {
            btnLike.setImage(UIImage(named: "like"), for: .normal)
            valueLike = String((valueLike as NSString).integerValue - 1)
            countLike.setTitle(valueLike, for: .normal)
         }
    }
    
    func configCell(_ data: PostModel){
        contentPost.text = data.contentPost
        lblDate.text = data.postDate
        imgPost.sd_setImage(with: URL(string: "\(data.postImageURL)")!, completed: nil)
        currentName.text = data.userPostName
        let path = "images/\(data.userPostEmail)_profile_picture.png"
        StorageManager.shared.downloadURL(for: path, completion: { [weak self] result in
            switch result {
            case .success(let url):

                DispatchQueue.main.async {
                    self?.profileImage.sd_setImage(with: url, completed: nil)
                }

            case .failure(let error):
                print("failed to get image url: \(error)")
            }
        })

    }
    
}
