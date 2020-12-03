//
//  EditDetailVC.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class EditDetailVC: UIViewController {
    var editTitle: String!
    var editUser: String!
    @IBOutlet weak var lblEditTitle: UILabel!
    @IBOutlet weak var lblEditTitle2: UILabel!
    @IBOutlet weak var lblWordLimit: UILabel!
    @IBOutlet weak var lbl30words: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tfEdit: UITextField!
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSaveAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        // Do any additional setup after loading the view.
    }
    func initUI(){
        tfEdit.delegate = self
        lblEditTitle.text = editTitle
        lblEditTitle2.text = editTitle
        tfEdit.text = editUser
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tfEdit.becomeFirstResponder()
    }
    
}
extension EditDetailVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblWordLimit.text = "\(textField.text?.count ?? 0)"
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        lblWordLimit.text = "0"
        lbl30words.textColor = UIColor.darkGray
        lblWordLimit.textColor = UIColor.darkGray
        btnSave.setTitleColor(UIColor.lightGray, for: .normal)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == tfEdit){
            if (editUser == tfEdit.text) {
                btnSave.setTitleColor(UIColor.lightGray, for: .normal)
            }
            let characterCountLimit = 30
            let newLength = (textField.text?.count ?? 0) + string.count - range.length
            
            lblWordLimit.text = "\(newLength)"
            lbl30words.textColor = UIColor.darkGray
            lblWordLimit.textColor = UIColor.darkGray
            btnSave.setTitleColor(BLUE_MAIN, for: .normal)
            if (newLength >= characterCountLimit) {
                lbl30words.textColor = #colorLiteral(red: 0.8089037538, green: 0.176630944, blue: 0.1133685037, alpha: 1)
                lblWordLimit.textColor = #colorLiteral(red: 0.8089037538, green: 0.176630944, blue: 0.1133685037, alpha: 1)
                lblWordLimit.text = "\(characterCountLimit)"
            }
            return newLength <= characterCountLimit
        }
        
        return true
    }
    
}
