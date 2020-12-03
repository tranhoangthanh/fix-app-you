//
//  SignUpVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import JGProgressHUD
class SignUpVC: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
    private let googleLoginButton = GIDSignInButton()
    private var loginObserver: NSObjectProtocol?
    let facebookLoginButton : FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["email,public_profile"]
        return button
    }()
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    
    @IBAction func btnshowPassAction(_ sender: Any) {
        tfPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        registerButtonTapped()
    }
    @IBAction func btnConfirmPassAction(_ sender: Any) {
        tfConfirmPassword.isSecureTextEntry.toggle()
        
    }
    @IBAction func btnSignInAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.delegate = self
        tfUsername.delegate = self
        tfPassword.delegate = self
        tfConfirmPassword.delegate = self
        facebookLoginButton.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
        imageView.addGestureRecognizer(gesture)
        
        
        facebookLoginButton.frame = CGRect(x: 40, y: view.frame.height - 130, width: view.frame.width - 80, height: 40)
        googleLoginButton.frame = CGRect(x: 35, y: view.frame.height - 80, width: view.frame.width - 70, height: 40)
        view.addSubview(facebookLoginButton)
        view.addSubview(googleLoginButton)
        loginObserver = NotificationCenter.default.addObserver(forName: .didLoginNotification, object: nil,
                                                               queue: .main,
                                                               using: {[weak self ] _ in
                                                                guard let strongSelf = self else {
                                                                    return
                                                                }
                                                                
                                                                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                                                                print("login success")
                                                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                                let homeVC = storyboard.instantiateViewController(withIdentifier: "Tabbar") as! TabbarViewController
                                                                homeVC.modalPresentationStyle = .fullScreen
                                                                self!.present(homeVC, animated: true, completion: nil)
                                                                
                                                               }
                                                               
        )
        
    }
    
    deinit {
        if let observer = loginObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 130
        }
    }
    func registerButtonTapped() {
        spinner.show(in: view)
        tfUsername.resignFirstResponder()
        tfEmail.resignFirstResponder()
        tfPassword.resignFirstResponder()
        tfConfirmPassword.resignFirstResponder()
        tfPassword.autocorrectionType = .no
        tfConfirmPassword.autocorrectionType = .no
        guard let userName = tfUsername.text,
              let password = tfPassword.text,
              let email = tfEmail.text,
              let cfpassword = tfConfirmPassword.text,
              !userName.isEmpty,
              !password.isEmpty,
              !email.isEmpty,
              !cfpassword.isEmpty
        else {
            alertError()
            return
        }
        // Fire base create user accouunt
        DatabaseManager.shared.userExists(with: email, completion: {[weak self] exist in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
            }
            guard !exist else {
                strongSelf.alertError(message: "A user account for that email already exists!")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                
                // [START_EXCLUDE]
                guard authResult != nil, error == nil else {
                    print("error creating user")
                    return
                }
                
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                let chatUser = ChatAppUser(userName: userName, emailAddress: email)
                DatabaseManager.shared.insertUser(with: chatUser, completion: { success in
                    if success {
                        // upload image
                        guard let image = strongSelf.imageView.image,
                              let data = image.pngData() else {
                            return
                        }
                        let filename = chatUser.profilePictureFileName
                        let folder = "images/"
                        StorageManager.shared.uploadPicture(with: data, fileName: filename, folder: folder, completion: { result in
                            switch result {
                            case .success(let downloadUrl):
                                UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                print(downloadUrl)
                                
                            case .failure(let error):
                                print("Storage maanger error: \(error)")
                            }
                        })
                    }
                })
                
            })
            
        })
        
    }
}

extension SignUpVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == tfUsername {
            tfEmail.becomeFirstResponder()
        }
        else if textField == tfEmail {
            tfPassword.becomeFirstResponder()
        }
        else if textField == tfPassword {
            tfConfirmPassword.becomeFirstResponder()
        }
        else if textField == tfConfirmPassword {
            registerButtonTapped()
        }
        
        return true
    }
    
}
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        self.imageView.image = selectedImage
        self.imageView.layer.cornerRadius = 80
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor.lightGray.cgColor
        self.imageView.clipsToBounds = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpVC: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {
            print("Fail login fb")
            return
        }
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields" : "email, name, picture.type(large)"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
        facebookRequest.start(completionHandler: { _, result, error in
            guard let result = result as? [String : Any]
                  , error == nil else {
                print("Fail to make facebook request")
                return
            }
            // vi result tra ve la file json, truy xuat de lay dc url
            guard let userName = result["name"] as? String,
                  let email = result["email"] as? String,
                  let picture = result["picture"] as? [String: Any],
                  let data = picture["data"] as? [String: Any],
                  let pictureURL = data["url"] as? String else {
                print("Fail to get email result from fb")
                return
            }
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(userName, forKey: "name")
            DatabaseManager.shared.userExists(with: email, completion: { exists in
                if !exists {
                    let chatUser = ChatAppUser(userName: userName, emailAddress: email)
                    DatabaseManager.shared.insertUser(with: chatUser, completion: { success in
                        if success {
                            // upload image
                            guard let url = URL(string: pictureURL) else {
                                return
                            }
                            URLSession.shared.dataTask(with: url, completionHandler: {data, _, _ in
                                guard let data = data else {
                                    return
                                }
                                
                                let filename = chatUser.profilePictureFileName
                                let folder = "images/"
                                StorageManager.shared.uploadPicture(with: data, fileName: filename, folder: folder, completion: { result in
                                    switch result {
                                    case .success(let downloadUrl):
                                        UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                        print("downloadUrl\(downloadUrl)")
                                        
                                        
                                        
                                    case .failure(let error):
                                        print("Storage maanger error: \(error)")
                                    }
                                })
                            }).resume()
                           
                            
                        }
                    })
                }
            })
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            FirebaseAuth.Auth.auth().signIn(with: credential, completion: {[weak self] authResult, error in
                guard let strongSelf = self else {
                    return
                }
                guard authResult != nil, error == nil else {
                    print("FB creaditial login fail")
                    return
                }
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                print("login success")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "Tabbar") as! TabbarViewController
                homeVC.modalPresentationStyle = .fullScreen
                self!.present(homeVC, animated: true, completion: nil)
            })
            
        })
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        
    }
    
    
}

