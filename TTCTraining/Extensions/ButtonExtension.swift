//
//  ButtonExtension.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
extension UIButton{
    func setBorderButton(_ borderWidth: CGFloat, _ borderColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}

