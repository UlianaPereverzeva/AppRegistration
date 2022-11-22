//
//  CreateAccountViewController.swift
//  AppRegistration
//
//  Created by ульяна on 22.11.22.
//

import UIKit

class CreateAccountViewController: UIViewController {

    
    
    // MARK: - Outlets
    
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    @IBOutlet var viewsIndicatorsOfPassword: [UIView]!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var errorConfirmPasswordLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    private var isValidEmail = false { didSet { updateContinueButtonState() }}
    private var isConfirmPassword = false { didSet { updateContinueButtonState() }}
    private var strengthOfPassword: StrengthOfPassword = .nothing { didSet { updateContinueButtonState() }}
    

    // MARK: - Life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - IBActions
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLabel.isHidden = isValidEmail
    }
    
    @IBAction func passwordTFAction(_ sender: UITextField) {
        
        
    }
    @IBAction func signInButton(_ sender: UIButton) {
    }
    @IBAction func confirmPasswordTF(_ sender: UITextField) {
    }
    @IBAction func continueButton(_ sender: UIButton) {
    }
    
    
    // MARK: - Func-s
    
    func updateContinueButtonState() {
        continueButton.isEnabled = isValidEmail && isConfirmPassword && strengthOfPassword != .nothing
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
