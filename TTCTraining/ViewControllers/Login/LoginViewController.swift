//
//  LoginViewController.swift
//  TTCTraining
//
//  Created by Apple on 10/23/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
class LoginViewController: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var topConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var topTravelMatesConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblTravelMates: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topConstraintHeight.constant = 1000
        logoTopConstraint.constant = 252
        topTravelMatesConstraint.constant = 446
        lblWelcome.isHidden = false
        lblTravelMates.font = UIFont(name:"Noteworthy", size: 45.0)
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    


    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 50
            
        }
    }
    
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        let signUpVC = SignUpVC(nibName: "SignUpVC", bundle: nil)
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
        
    }
    
    @IBAction func btnShowPasswordAction(_ sender: Any) {
        tfPassword.isSecureTextEntry.toggle()
    }
    @IBAction func hideSigInPop(_ sender: Any) {
        topConstraintHeight.constant = 1000
        logoTopConstraint.constant = 252
        topTravelMatesConstraint.constant = 446
        lblTravelMates.font = UIFont(name:"Noteworthy", size: 45.0)
        lblWelcome.isHidden = false
        guard let email = self.tfEmail.text, let password = self.tfPassword.text else {
            return
        }
        spinner.show(in: view)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations:{ self.view.layoutIfNeeded()}, completion: { (_) in
           
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password , completion: {
                [weak self] authResult, error in
              
                guard let strongSelf = self else {
                    return
                }
                strongSelf.spinner.dismiss()
                guard let _ = authResult, error == nil else {
                   
                    if (email == "" || password == "") {
                        let alert: UIAlertController = UIAlertController(title: "Thông báo", message: "Vui lòng nhập đầy đủ thông tin", preferredStyle: .alert)
                        let btn_Ok: UIAlertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                        alert.addAction(btn_Ok)
                      
                        self!.present(alert, animated: true, completion: nil)
                    } else{
                        let alert: UIAlertController = UIAlertController(title: "Thông báo", message: "Tên đăng nhập hoặc mật khẩu không chính xác", preferredStyle: .alert)
                        let btn_Ok: UIAlertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                        alert.addAction(btn_Ok)
                      
                        self?.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
                DatabaseManager.shared.getDataFor(path: safeEmail, completion: { result in
                    switch result {
                    case .success(let data):
                        guard let userData = data as? [String: Any],
                            let userName = userData["user_name"] as? String else {
                                return
                        }
                        UserDefaults.standard.set("\(userName)", forKey: "name")

                    case .failure(let error):
                        print("Failed to read data with error \(error)")
                    }
                })
                
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                
                let homeVC = self?.storyboard?.instantiateViewController(withIdentifier: "Tabbar") as! TabbarViewController
                homeVC.modalPresentationStyle = .fullScreen
                self!.present(homeVC, animated: true, completion: nil)
                
                UserDefaults.standard.set(email, forKey: "email")

                DispatchQueue.main.async {
                    strongSelf.spinner.dismiss()
                }
            })
            
        })
    }
    
    @IBAction func showLoginPop(_ sender: Any) {
        topConstraintHeight.constant = 180
        logoTopConstraint.constant = 50
        topTravelMatesConstraint.constant = 175
        
        lblTravelMates.font = UIFont(name:"Noteworthy", size: 25.0)
        
        lblWelcome.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations:{ self.view.layoutIfNeeded()}, completion: nil)
        print("clicked")
    }
    
}

