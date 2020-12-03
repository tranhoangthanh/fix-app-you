//
//  TestViewController.swift
//  TTCTraining
//
//  Created by Bui Tam on 9/17/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Firebase

class TestViewController: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var createAcc: UIButton!
    @IBAction func createAcct(_ sender: Any) {
        Firebase.Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPass.text!, completion: { authResult, error in
                  guard let result = authResult, error == nil else {
                      print("error creating user")
                      return
                  }
                  let user = result.user
                  print("user: \(user)")
              })
    }
    private let database = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        database.child("something31").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String : Any] else {
                return
            }
            print("value: \(value)")
        })

      
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddEntryToDB(_ sender: Any) {
        let object : [String : Any] = [
            "name" : "ios" as NSObject,
            "fb" : "no"
        ]
        database.child("something\(Int.random(in: 0..<100))").setValue(object)
    }
    
    

}

