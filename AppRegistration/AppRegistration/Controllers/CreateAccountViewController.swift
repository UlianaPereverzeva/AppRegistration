//
//  CreateAccountViewController.swift
//  AppRegistration
//
//  Created by ульяна on 22.11.22.
//

import UIKit

class CreateAccountViewController: UIViewController {

    
    
    // MARK: - Outlets
    
    @IBOutlet private weak var errorEmailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var errorPasswordLabel: UILabel!
    @IBOutlet private var viewsIndicatorsOfPassword: [UIView]!
    @IBOutlet private weak var confirmPasswordTF: UITextField!
    @IBOutlet private weak var errorConfirmPasswordLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    private var isValidEmail = false { didSet { updateContinueButtonState() }}
    private var isConfirmPassword = false { didSet { updateContinueButtonState() }}
    private var strengthOfPassword: StrengthOfPassword = .nothing { didSet { updateContinueButtonState() }}
    

    // MARK: - Life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewsIndicatorsOfPassword.forEach { view in
            view.isHidden = true
        }
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    

    // MARK: - IBActions
    
    @IBAction private func emailTFAction(_ sender: UITextField) {
        
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLabel.isHidden = isValidEmail
    }
    
    
    @IBAction private func passwordTFAction(_ sender: UITextField) {
        
        if let pass = sender.text,
           !pass.isEmpty {
           strengthOfPassword = VerificationService.isValidPassword(pass: pass)
        } else {
            strengthOfPassword = .nothing
        }
        errorPasswordLabel.isHidden = strengthOfPassword != .nothing
        setUpStrongPassIndicatorsViews()
    }
    
    
    @IBAction private func signInButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction private func confirmPasswordTF(_ sender: UITextField) {
        if let confirmPsswordText = sender.text,
           !confirmPsswordText.isEmpty,
           let passText = passwordTextField.text,
           !passText.isEmpty {
           isConfirmPassword = VerificationService.isConfirm(pass1: confirmPsswordText, pass2: passText)
            
        } else {
           isConfirmPassword = false
        }
        errorConfirmPasswordLabel.isHidden = isConfirmPassword
    }
    @IBAction private func continueButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        let userModel = UserModel(name: nameTextField.text, email: email, password: password)
        
        let storyboard = UIStoryboard(name: "SignupStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "VerificationsVC") as? VerificationsVC else {
            return
        }
        vc.userModel = userModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Func-s
    
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
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    private func updateContinueButtonState() {
        continueButton.isEnabled = isValidEmail && isConfirmPassword && strengthOfPassword != .nothing
    }
    
    private func setUpStrongPassIndicatorsViews() {
        
        if strengthOfPassword.rawValue == 0 {
            viewsIndicatorsOfPassword.forEach { view in
                view.isHidden = true
            }
            return
        }
        
            
        viewsIndicatorsOfPassword.enumerated().forEach { index, view in
            view.isHidden = false
            
            if index <= (strengthOfPassword.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.1
            }
                
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
