//
//  EditProfileVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editProfileTableView: UITableView!
    var lstEditProfile = EditProfileMD.initEditProfile()
    @IBAction func btnBackAction(_ sender: Any) {
        createAnimated(self: self)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var editProfileTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    func initData(){
    }
    
    func initUI(){
        editProfileTableView.delegate = self
        editProfileTableView.dataSource = self
        editProfileTableView.register(UINib(nibName: "EditProfileTBVCell", bundle: nil), forCellReuseIdentifier: "EditProfileTBVCell")
        editProfileTableViewHeight.constant = CGFloat(lstEditProfile.count * 50)
        setImageProfile(profileImage: profileImage)
    }
    @IBAction func changePhotoAction(_ sender: Any) {
        presentPhotoActionSheet()
    }
}

// MARK: - TableViewDelegates and datasources
extension EditProfileVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstEditProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editProfileTableView.dequeueReusableCell(withIdentifier: "EditProfileTBVCell", for: indexPath) as? EditProfileTBVCell
        cell?.configCell(lstEditProfile[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editDetailVC = EditDetailVC(nibName: "EditDetailVC", bundle: nil) as EditDetailVC
        editDetailVC.editTitle = lstEditProfile[indexPath.row].infoItem
        editDetailVC.editUser = lstEditProfile[indexPath.row].infoUser
        editDetailVC.modalPresentationStyle = .fullScreen
        createAnimated(self: self)
        self.present(editDetailVC, animated: false, completion: nil)
    }
}
extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                
                                                self?.presentCamera()
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                
                                                self?.presentPhotoPicker()
                                            }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.profileImage.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
