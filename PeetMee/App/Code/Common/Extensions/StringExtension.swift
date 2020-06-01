//
//  StringExtension.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 06/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation

extension String {

    var Localized: String {
      return NSLocalizedString(self, tableName: localize, bundle: Bundle.main, value: "", comment: "")
    }

    func isValidEmail() -> Bool {
         let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
         let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         return emailTest.evaluate(with: self)
     }

    func isValidPassword() -> Bool {
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: self)
    }
}
