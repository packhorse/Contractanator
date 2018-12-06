//
//  SignUpViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/28/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    var themeColor = UIColor(named: "CoolBlue")

    // MARK: - Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextfield: UITextField!
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIChanges()
        
    }
    
    // MARK: - Functions
    
    func setupViewFor(_ textField: UITextField) {
        
        textField.layer.cornerRadius = 21
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.masksToBounds = true
        textField.setLeftPaddingPoints(15)
        textField.setLeftPaddingPoints(15)
    }
    
    func UIChanges() {
        
        // textFields
        setupViewFor(firstNameTextField)
        setupViewFor(lastNameTextField)
        setupViewFor(usernameTextField)
        setupViewFor(phoneTextField)
        setupViewFor(emailTextField)
        setupViewFor(passwordTextField)
        setupViewFor(confirmPasswordTextfield)
        
        //SignUpButton
        signUpButton.layer.cornerRadius = 18.0
        signUpButton.layer.shadowColor = themeColor?.cgColor
        signUpButton.layer.shadowRadius = 4
        signUpButton.layer.shadowOpacity = 1
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.layer.borderColor = themeColor?.cgColor
        signUpButton.layer.backgroundColor = themeColor?.cgColor
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
