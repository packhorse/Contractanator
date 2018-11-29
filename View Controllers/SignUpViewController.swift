//
//  SignUpViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/28/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextfield: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIChanges()
        
    }
    
    
    func UIChanges() {
        
        //SignUpButton
        signUpButton.layer.cornerRadius = 18.0
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor.lightGray.cgColor
        
        
        //usernameTextField
        usernameTextField.layer.cornerRadius = 21
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextField.borderStyle = .none
        usernameTextField.layer.masksToBounds = true
        
        
        //EmailTextField
        emailTextField.layer.cornerRadius = 21
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.borderStyle = .none
        emailTextField.layer.masksToBounds = true
        
        
        
        //PasswordTextField
        passwordTextField.layer.cornerRadius = 21
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.borderStyle = .none
        passwordTextField.layer.masksToBounds = true
        
        
        //ConfirmPasswordTextField
        confirmPasswordTextfield.layer.cornerRadius = 21
        confirmPasswordTextfield.layer.borderWidth = 1.0
        confirmPasswordTextfield.layer.borderColor = UIColor.lightGray.cgColor
        confirmPasswordTextfield = .none
        
        
        
        
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
