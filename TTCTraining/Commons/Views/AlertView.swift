//
//  AlertView.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class AlertView: UIView {

     
        @IBOutlet weak var alertView: UIView!
        @IBOutlet var contentView: UIView!
        @IBOutlet weak var backgroundView: UIVisualEffectView!
        
        
        @IBOutlet weak var btnAccept: UIButton!
        @IBOutlet weak var btnCancel: UIButton!
        
        @IBOutlet weak var lblTitle: UILabel!
        @IBOutlet weak var lblSubTitle: UILabel!
        @IBOutlet weak var lblMainText: UILabel!
        
        var didAccept: (() -> Void)?
        var didCancel: (() -> Void)?
        
        init(alertTitle: String? = nil, sub alertSubTitle: String? = nil, alertMainText: String, haveCancel: Bool = true, didAccept: (() -> Void)? = nil, didCancel: (() -> Void)? = nil){
            super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            commonInit()
            if let title = alertTitle{
                lblTitle.text = title.trim()
            }else{
                lblTitle.text = "Thông báo"
            }
            
            if let sub = alertSubTitle{
                lblSubTitle.isHidden = false
                lblSubTitle.text = sub.trim()
            }else{
                lblSubTitle.isHidden = true
            }
            
            lblMainText.text = alertMainText.trim()
            
            btnCancel.isHidden = !haveCancel
            self.didAccept = didAccept
            self.didCancel = didCancel
            
            initUI()
        }
        
        public func show() {
            var topController = UIApplication.shared.keyWindow?.rootViewController
            while (topController?.presentedViewController != nil) {
                topController = topController?.presentedViewController
            }
            topController?.view.addSubview(self)
            showView()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
            initUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
            initUI()
        }
        
        private func commonInit(){
            Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        
        private func initUI(){
            alertView.setRadius()
            btnAccept.setRadius()
            btnCancel.setRadius()
            alertView.alpha = 0.01
        }
        
        // MARK: - Functions
        private func showView(){
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn], animations: {
                self.backgroundView.alpha = 0.4
                self.alertView.transform = CGAffineTransform(translationX: 0.0, y: 60.0)
                self.alertView.alpha = 1
            }, completion: nil)
        }
        
        private func hideView() {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {
                self.backgroundView.alpha = 0.01
                self.alertView.transform = CGAffineTransform.identity
                self.alertView.alpha = 0.01
            }){  finish in
                self.removeFromSuperview()
            }
        }
        
        // MARK: - Actions
        @IBAction func acceptAction(_ sender: Any) {
            if let accept = didAccept{
                accept()
            }
            hideView()
        }
        
        @IBAction func cancelAction(_ sender: Any) {
            if let cancel = didCancel{
                cancel()
            }
            hideView()
        }
        
    }
