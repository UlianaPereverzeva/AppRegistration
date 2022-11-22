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
    
        static let weakRegex          = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        static let notVeryStrongRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        static let strongRegex        = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        
        static func isValidPassword(pass: String) -> StrengthOfPassword {
            if NSPredicate(format: "SELF MATCHES %@", strongRegex).evaluate(with: pass) {
                return .strong
            } else if NSPredicate(format: "SELF MATCHES %@", notVeryStrongRegex).evaluate(with: pass) {
                return .ok
            } else if NSPredicate(format: "SELF MATCHES %@", weakRegex).evaluate(with: pass) {
                return .weak
            } else {
                return .nothing
            }
        }
    
        static func isValidEmail(email:String?) -> Bool {
        
            guard email != nil else { return false }
            
            let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{10,26}"
            
            let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
            return pred.evaluate(with: email)
        }
    
    
}
