//
//  LogInViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/28/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    var themeColor = UIColor(named: "CoolBlue")
    
    // MARK: - Outlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    // Error labels
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        UIChanges()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        // Hide error if shown previously
        self.errorLabel.isHidden = true
        
        attemptSignIn()
    }
    
    
    func UIChanges() {
        
        //EmailTextField
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.layer.borderWidth = 1.0
        emailTextField.borderStyle = .none
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.masksToBounds = true
        emailTextField.setLeftPaddingPoints(15)
        emailTextField.setRightPaddingPoints(15)
        
        //PasswordTextField
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.borderStyle = .none
        passwordTextField.layer.masksToBounds = true
        passwordTextField.setLeftPaddingPoints(15)
        passwordTextField.setRightPaddingPoints(15)
        
        //SignInButton
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        signInButton.layer.shadowColor = themeColor?.cgColor
        signInButton.layer.shadowRadius = 4
        signInButton.layer.shadowOpacity = 1
        signInButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        signInButton.layer.borderWidth = 1.0
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.layer.borderColor = themeColor?.cgColor
        signInButton.layer.backgroundColor = themeColor?.cgColor
        
        // Icon Color
        iconImageView.tintColor = themeColor
    }
    
    // MARK: - Functions
    
    func attemptSignIn() {
        
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else { return }
        
        UserController.shared.signInUser(withEmail: email, password: password) { (success, signInError) in
            if success {
                
                let tabBarVC = self.presentingViewController as! UITabBarController
                let navCont = tabBarVC.selectedViewController as! UINavigationController
                
                if !(navCont.viewControllers[0] is PostViewController) {
                    tabBarVC.selectedIndex = 2
                } else {
                    let postVC = navCont.viewControllers[0] as? PostViewController
                    if postVC?.attemptedPost == false {
                        tabBarVC.selectedIndex = 2
                    }
                }
                self.dismiss(animated: true, completion: nil)
            } else {
                
                if let signInError = signInError {
                    
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = signInError.rawValue
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignUpVC" {
            let destinationVC = segue.destination as! SignUpViewController
            
            destinationVC.themeColor = themeColor
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            
            passwordTextField.becomeFirstResponder()
        }
        
        if textField == passwordTextField {
            
            passwordTextField.resignFirstResponder()
            attemptSignIn()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == emailTextField {
            
            if text.isValidEmail() || text.isEmpty {
                emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                emailTextField.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
}
