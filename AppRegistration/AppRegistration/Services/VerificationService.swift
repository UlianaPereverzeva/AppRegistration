//
//  VerificationService.swift
//  AppRegistration
//
//  Created by ульяна on 22.11.22.
//

import Foundation

enum StrengthOfPassword: Int {
    case nothing
    case weak
    case ok
    case strong
}

final class VerificationService {
    
   static func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{10,26}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
}
