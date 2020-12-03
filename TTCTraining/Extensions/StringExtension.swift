//
//  StringExtension.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

extension String{
    func trim() -> String {
          return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      }
    
    func split(_ delimiter: String) -> [String] {
           return self.components(separatedBy: delimiter)
       }
}

extension Optional where Wrapped == String {
    func value(_ defaultValue: String = "") -> String {
        return self ?? defaultValue
    }
}

extension NSNotification.Name {
    static let didLoginNotification = Notification.Name("didLoginNotification")
}
