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
    
    
    var userModel: UserModel?
    var randomNumber = Int.random(in: 100000 ... 999999)
    
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: -  Actions

    @IBAction func codeTextFieldAction(_ sender: UITextField) {
        guard let text = sender.text,
              !text.isEmpty,
        text == randomNumber.description else {
            errorLabel.isHidden = false
        }
        
    }
    
    
    // MARK: -  Functions
    
    private func setUpUI() {
        emailLabel.text = userModel?.email
        codeLabel.text = String(randomNumber)
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
