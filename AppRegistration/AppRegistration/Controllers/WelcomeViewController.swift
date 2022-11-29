//
//  WelcomViewController.swift
//  AppRegistration
//
//  Created by ульяна on 29.11.22.
//

import UIKit

class WelcomeViewController: UIViewController {

    var userModel: UserModel?
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }
    

    @IBAction func continueButtonAction() {
        guard let userModel = userModel else { return }

        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setUpUI() {
        infoLabel.text = "Nice to meet you \(userModel?.name ?? "")"
    }

}
