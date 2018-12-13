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
    
    var themeColor = UIColor(named: Constants.coolBlue)

    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phone1TextField: UITextField!
    @IBOutlet weak var phone2TextField: UITextField!
    @IBOutlet weak var phone3TextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // Error Labels
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIChanges()
        
        // Delegates
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        phone1TextField.delegate = self
        phone2TextField.delegate = self
        phone3TextField.delegate = self
        bioTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextfield.delegate = self

        // Listen to username, passwords and phone TextField edits
        usernameTextField.addTarget(self, action: #selector(editingDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(editingDidChange(_:)), for: .editingChanged)
        confirmPasswordTextfield.addTarget(self, action: #selector(editingDidChange(_:)), for: .editingChanged)
        phone1TextField.addTarget(self, action: #selector(editingDidChange(_:)), for: .editingChanged)
        phone2TextField.addTarget(self, action: #selector(editingDidChange(_:)), for: .editingChanged)
        phone3TextField.addTarget(self, action: #selector(editingDidChange(_:)), for: .editingChanged)
        
        
        // Keyboard show and hide notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIWindow.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
        
        // Keyboard hides on tap geasture
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Actions
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        view.endEditing(true)
        
        presentingViewController?.dismiss(animated: false, completion: nil)
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
        textField.setRightPaddingPoints(15)
    }
    
    func UIChanges() {
        
        // textFields
        setupViewFor(firstNameTextField)
        setupViewFor(lastNameTextField)
        setupViewFor(usernameTextField)
        setupViewFor(phone1TextField)
        setupViewFor(phone2TextField)
        setupViewFor(phone3TextField)
        setupViewFor(bioTextField)
        setupViewFor(emailTextField)
        setupViewFor(passwordTextField)
        setupViewFor(confirmPasswordTextfield)
        
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
            let bio = bioTextField.text, !bio.isEmpty,
            let phone1 = phone1TextField.text, !phone1.isEmpty,
            let phone2 = phone2TextField.text, !phone2.isEmpty,
            let phone3 = phone3TextField.text, !phone3.isEmpty,
            let email = emailTextField.text, !email.isEmpty, email.isValidEmail(),
            let password = passwordTextField.text, !password.isEmpty, password.count >= 6,
            let confirmPassword = confirmPasswordTextfield.text, !confirmPassword.isEmpty, password == confirmPassword
            else { return }
        
        let phone = phone1 + phone2 + phone3
        
        UserController.shared.createNewUser(withFirstName: firstName, lastName: lastName, username: username, phone: phone, bio: bio, email: email, password: password) { (success) in
            if success {
                
                let tabBarVC = self.presentingViewController?.presentingViewController as! UITabBarController
                let navCont = tabBarVC.selectedViewController as! UINavigationController
                
                if !(navCont.viewControllers[0] is PostViewController) {
                    tabBarVC.selectedIndex = 2
                } else {
                    let postVC = navCont.viewControllers[0] as? PostViewController
                    if postVC?.attemptedPost == false {
                        tabBarVC.selectedIndex = 2
                    }
                }
                self.dismiss(animated: false, completion: nil)
                
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Listeners for editing changes
    
    @objc func editingDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        let count = text.count
        
        switch textField {
        case usernameTextField:
            if count >= 4 {
                UserController.shared.isUsernameAvailable(withUsername: text) { (isAvailable) in
                    if isAvailable {
                        self.usernameErrorLabel.text = SignUpErrors.usernameAvailable.rawValue
                        self.usernameErrorLabel.textColor = self.themeColor
                        textField.layer.borderColor = self.themeColor?.cgColor
                    } else {
                        self.usernameErrorLabel.text = SignUpErrors.usernameTaken.rawValue
                        self.usernameErrorLabel.textColor = UIColor.red
                        textField.redBorders()
                    }
                    self.usernameErrorLabel.isHidden = false
                }
            } else {
                usernameErrorLabel.isHidden = true
                textField.layer.borderColor = UIColor.lightGray.cgColor
            }
        case phone1TextField:
            if count == 3 {
                phone2TextField.becomeFirstResponder()
            }
        case phone2TextField:
            if count == 3 {
                phone3TextField.becomeFirstResponder()
            }
        case phone3TextField:
            if count == 4 {
                emailTextField.becomeFirstResponder()
            }
        case passwordTextField:
            if count >= 6 {
                passwordErrorLabel.isHidden = true
                textField.layer.borderColor = UIColor.lightGray.cgColor
            }
        case confirmPasswordTextfield:
            if passwordTextField.text == text && !text.isEmpty {
                passwordErrorLabel.isHidden = true
                confirmPasswordErrorLabel.isHidden = true
            }
        default:
            break
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
            bioTextField.becomeFirstResponder()
        case bioTextField:
            phone1TextField.becomeFirstResponder()
            
        // The phone text fields use a listener to tab through the text fields
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextfield.becomeFirstResponder()
        case confirmPasswordTextfield:
            confirmPasswordTextfield.resignFirstResponder()
            attemptSignUp()
        default:
            view.endEditing(true)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        let count = text.count
        
        if text.isEmpty {
            textField.redBorders()
        } else {
            textField.lightGrayBorders()
        }
        
        switch textField {
        case firstNameTextField:
            firstNameTextField.text = firstNameTextField.text?.trimmingCharacters(in: .whitespaces)
        case lastNameTextField:
            lastNameTextField.text = lastNameTextField.text?.trimmingCharacters(in: .whitespaces)
        case usernameTextField:
            if count >= 4 {
                UserController.shared.isUsernameAvailable(withUsername: text) { (isAvailable) in
                    if isAvailable {
                        self.usernameErrorLabel.text = SignUpErrors.usernameAvailable.rawValue
                        self.usernameErrorLabel.textColor = self.themeColor
                        textField.layer.borderColor = self.themeColor?.cgColor
                    } else {
                        self.usernameErrorLabel.text = SignUpErrors.usernameTaken.rawValue
                        self.usernameErrorLabel.textColor = UIColor.red
                        textField.redBorders()
                    }
                    self.usernameErrorLabel.isHidden = false
                }
            } else {
                usernameErrorLabel.textColor = UIColor.red
                usernameErrorLabel.text = SignUpErrors.tooShort.rawValue
                usernameErrorLabel.isHidden = false
                textField.redBorders()
            }
        case phone1TextField:
            if count < 3 {
                textField.redBorders()
            }
        case phone2TextField:
            if count < 3 {
                textField.redBorders()
            }
        case phone3TextField:
            if count < 4 {
                textField.redBorders()
            }
        case bioTextField:
            bioTextField.text = bioTextField.text?.trimmingCharacters(in: .whitespaces)
        case emailTextField:
            emailTextField.text = emailTextField.text?.trimmingCharacters(in: .whitespaces)
            if text.isValidEmail() {
                emailTextField.layer.borderColor = UIColor.lightGray.cgColor
                emailErrorLabel.isHidden = true
            } else {
                emailTextField.redBorders()
                emailErrorLabel.text = SignUpErrors.invalidEmail.rawValue
                emailErrorLabel.isHidden = false
            }
        case passwordTextField:
            if count < 6 {
                passwordErrorLabel.text = SignUpErrors.tooShort.rawValue
                passwordErrorLabel.isHidden = false
            } else {
                passwordErrorLabel.isHidden = true
            }
        case confirmPasswordTextfield:
            if passwordTextField.text != confirmPasswordTextfield.text {
                passwordErrorLabel.text = SignUpErrors.passwordMismatch.rawValue
                confirmPasswordErrorLabel.text = SignUpErrors.passwordMismatch.rawValue
                
                passwordErrorLabel.isHidden = false
                confirmPasswordErrorLabel.isHidden = false
            } else {
                if !text.isEmpty{
                    passwordErrorLabel.isHidden = true
                    confirmPasswordErrorLabel.isHidden = true
                }
            }
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        
        switch textField {
        case firstNameTextField:
            break
        case lastNameTextField:
            break
        case usernameTextField:
            if string == " " {
                return false
            }
            return count <= 15
        case phone1TextField:
            return count <= 3
        case phone2TextField:
            return count <= 3
        case phone3TextField:
            return count <= 4
        case bioTextField:
            break
        case emailTextField:
            break
        default:
            break
        }
        
        return true
    }
}

extension UITextField {
    
    func redBorders() {
        
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func lightGrayBorders() {
        
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
