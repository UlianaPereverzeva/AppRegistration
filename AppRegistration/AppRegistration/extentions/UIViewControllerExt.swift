//
//  UIViewControllerExt.swift
//  AppRegistration
//
//  Created by ульяна on 22.11.22.
//

import UIKit


extension UIViewController {
    
    // чтобы по нажатию на задний фон клавиатура закрывалась

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
