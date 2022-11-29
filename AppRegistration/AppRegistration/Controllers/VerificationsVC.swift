//
//  VerificationsVC.swift
//  AppRegistration
//
//  Created by ульяна on 28.11.22.
//

import UIKit

final class VerificationsVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var codeLabel: UILabel!
    @IBOutlet private weak var codeTextField: UITextField!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    var userModel: UserModel?
    var randomNumber = Int.random(in: 100000 ... 999999)
    var sleepTime: Double = 3
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    // MARK: -  Actions

    @IBAction func codeTextFieldAction(_ sender: UITextField) {
        guard let text = sender.text,
              !text.isEmpty,
        text == randomNumber.description else {
            errorLabel.isHidden = false
            errorLabel.text = "Incorrect code. Please wait \(sleepTime) seconds"
            sender.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + sleepTime) { [weak self] in
                sender.isUserInteractionEnabled = true
                self?.errorLabel.isHidden = true
                self?.sleepTime *= 2
            }
            return
        }
        
        
         let storyboard = UIStoryboard(name: "SignupStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else {
            return
        }
        vc.userModel = userModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: -  Functions
    
    private func setUpUI() {
        emailLabel.text = userModel?.email
        codeLabel.text = String(randomNumber)
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
        centerYConstraint.constant -= keyboardSize.height / 2
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        centerYConstraint.constant += keyboardSize.height / 2
        self.view.layoutIfNeeded()
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
