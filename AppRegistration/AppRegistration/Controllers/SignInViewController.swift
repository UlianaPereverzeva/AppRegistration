//
//  SignInViewController.swift
//  AppRegistration
//
//  Created by ульяна on 22.11.22.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var constraintY: NSLayoutConstraint!
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    

    @IBAction func emailTFAction(_ sender: UITextField) {
        updateContinueButtonState()
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        updateContinueButtonState()
    }
    
    @IBAction func signInButtonAction() {
         
    }
    private func updateContinueButtonState() {
        if emailTF.text == UserDefaultsService.getUserModel()?.email,
           passwordTF.text == UserDefaultsService.getUserModel()?.password {
            continueButton.isEnabled = true
            errorEmailLabel.isHidden = true
            errorPasswordLabel.isHidden = true
        } else if emailTF.text != UserDefaultsService.getUserModel()?.email {
            errorEmailLabel.isHidden = false
            if passwordTF.text != UserDefaultsService.getUserModel()?.password {
            errorPasswordLabel.isHidden = false
            }
        }
        
    }
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        constraintY.constant = -keyboardSize.height / 2
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        constraintY.constant = keyboardSize.height / 2
        self.view.layoutIfNeeded()
    }
}

