//
//  LogInViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/28/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      UIChanges()
        
    }
    
    func UIChanges() {
        
        //SignInButton
        signInButton.layer.cornerRadius = 18.0
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = UIColor.lightGray.cgColor
        
        //EmailTextField
        emailTextField.layer.cornerRadius = 21
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.borderStyle = .none
        emailTextField.layer.masksToBounds = true
//        emailTextField.position(from: emailTextField.beginningOfDocument, in: .right, offset: 15)
        
        
        
        //PasswordTextField
        passwordTextField.layer.cornerRadius = 21
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.borderStyle = .none
        passwordTextField.layer.masksToBounds = true
        

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
