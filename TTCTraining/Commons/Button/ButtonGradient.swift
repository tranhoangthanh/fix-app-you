//
//  ButtonGradient.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
@IBDesignable class ButtonGradientBlue: TouchEffectButton {
        let gradient = CAGradientLayer()
        
        @IBInspectable var isGradientBorder: Bool = false {
            didSet {
                setupView()
            }
        }
        override func awakeFromNib() {
            super.awakeFromNib()
            
        }
        
        // MARK: - Layout
        override public func layoutSubviews() {
            super.layoutSubviews()
            
            gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
            setupView()
        }
        
        private func setupView() {
            titleLabel?.textColor = UIColor.white
            layer.masksToBounds = true
            layer.cornerRadius = bounds.height/2
            
            gradient.colors = [UIColor(red: 0, green: 0.7, blue: 0.93, alpha: 1).cgColor, UIColor(red: 0, green: 0.38, blue: 0.83, alpha: 1).cgColor]

            gradient.frame = bounds
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            
            self.layer.insertSublayer(gradient, at: 0)
            if isGradientBorder {
                let shape = CAShapeLayer()
                shape.lineWidth = 1.5
                shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 50).cgPath
                shape.strokeColor = UIColor.black.cgColor
                shape.fillColor = UIColor.clear.cgColor
                gradient.mask = shape
            }
        }
    }
@IBDesignable class ButtonGradientRed: TouchEffectButton {
    let gradient = CAGradientLayer()
    
    @IBInspectable var isGradientBorder: Bool = false {
        didSet {
            setupView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
        setupView()
    }
    
    private func setupView() {
        titleLabel?.textColor = UIColor.white
        layer.masksToBounds = true
        layer.cornerRadius = bounds.height/2
        
        gradient.colors = [UIColor(red: 0.96, green: 0.4235, blue: 0.117645, alpha: 1).cgColor, UIColor(red: 0.749, green: 0.0901, blue: 0.0745, alpha: 1).cgColor]

        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradient, at: 0)
        if isGradientBorder {
            let shape = CAShapeLayer()
            shape.lineWidth = 1.5
            shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 50).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            gradient.mask = shape
        }
    }
}

@IBDesignable class ButtonGradientPurple: TouchEffectButton {
    let gradient = CAGradientLayer()
    
    @IBInspectable var isGradientBorder: Bool = false {
        didSet {
            setupView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
        setupView()
    }
    
    private func setupView() {
        titleLabel?.textColor = UIColor.white
        layer.masksToBounds = true
        layer.cornerRadius = bounds.height/2
        
        gradient.colors = [UIColor(red: 0.792, green: 0.157, blue: 0.553, alpha: 1).cgColor, UIColor(red: 0.4, green: 0.145, blue: 0.81, alpha: 1).cgColor]

        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradient, at: 0)
        if isGradientBorder {
            let shape = CAShapeLayer()
            shape.lineWidth = 1.5
            shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 50).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            gradient.mask = shape
        }
    }
}
