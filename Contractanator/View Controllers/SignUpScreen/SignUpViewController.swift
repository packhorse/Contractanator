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
    
    var isFromProfileVC = false
    var themeColor = UIColor(named: "CoolBlue")

    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextfield: UITextField!
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextfield.delegate = self

        UIChanges()
        
        // Keyboard show and hide notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIWindow.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
        
        // Keyboard hides on tap geasture
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Actions
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        view.endEditing(true)
        
        if isFromProfileVC {
            if let loginVC = self.presentingViewController as? LogInViewController {
                self.dismiss(animated: false) {
                    
                    loginVC.dismissToHomeVC()
                }
            }
        } else {
            if let loginVC = self.presentingViewController as? LogInViewController {
                self.dismiss(animated: false) {
                    
                    loginVC.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        attemptSignUp()
    }
    
    @IBAction func goToLoginButtonTapped(_ sender: UIButton) {
        
        view.endEditing(true)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Update Functions
    
    func setupViewFor(_ textField: UITextField) {
        
        textField.layer.cornerRadius = textField.frame.height / 2
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
        setupViewFor(bioTextField)
        setupViewFor(emailTextField)
        setupViewFor(passwordTextField)
        setupViewFor(confirmPasswordTextfield)
        
        // Bio text field
        bioTextField.adjustsFontSizeToFitWidth = true
        bioTextField.minimumFontSize = CGFloat(10)
        
        //SignUpButton
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.layer.shadowColor = themeColor?.cgColor
        signUpButton.layer.shadowRadius = 4
        signUpButton.layer.shadowOpacity = 1
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        signUpButton.layer.borderWidth = 1.0
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.layer.borderColor = themeColor?.cgColor
        signUpButton.layer.backgroundColor = themeColor?.cgColor
    }
    
    // MARK: - Functions
    
    func attemptSignUp() {
        
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let username = usernameTextField.text, !username.isEmpty,
            let phone = phoneTextField.text, !phone.isEmpty,
            let bio = bioTextField.text, !bio.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let confirmPassword = confirmPasswordTextfield.text, !confirmPassword.isEmpty,
            password == confirmPassword
            else { view.endEditing(true) ; return }
        
        UserController.shared.createNewUser(withFirstName: firstName, lastName: lastName, username: username, phone: phone, bio: bio, email: email, password: password) { (success) in
            if success {
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Keyboard Handlers
    
    @objc func keyboardDidShow(notification: NSNotification) {
        
        var info = notification.userInfo!
        let keyBoardSize = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrollView.contentInset.bottom = keyBoardSize.height
        scrollView.scrollIndicatorInsets.bottom = keyBoardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentInset.bottom = 0
            self.scrollView.scrollIndicatorInsets.bottom = 0
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            usernameTextField.becomeFirstResponder()
        case usernameTextField:
            phoneTextField.becomeFirstResponder()
        case phoneTextField:
            bioTextField.becomeFirstResponder()
        case bioTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextfield.becomeFirstResponder()
        case confirmPasswordTextfield:
            attemptSignUp()
        default:
            view.endEditing(true)
        }
        
        return true
    }
}
