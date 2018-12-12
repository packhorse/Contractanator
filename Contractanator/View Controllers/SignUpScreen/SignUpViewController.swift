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

        // Listen to certain TextFields
        phone1TextField.addTarget(self, action: #selector(advanceFirstResponder(_:)), for: .editingChanged)
        phone2TextField.addTarget(self, action: #selector(advanceFirstResponder(_:)), for: .editingChanged)
        phone3TextField.addTarget(self, action: #selector(advanceFirstResponder(_:)), for: .editingChanged)
        
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
        textField.setLeftPaddingPoints(15)
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
            let phone1 = phone1TextField.text, !phone1.isEmpty,
            let phone2 = phone2TextField.text, !phone2.isEmpty,
            let phone3 = phone3TextField.text, !phone3.isEmpty,
            let bio = bioTextField.text, !bio.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let confirmPassword = confirmPasswordTextfield.text, !confirmPassword.isEmpty,
            password == confirmPassword
            else { view.endEditing(true) ; return }
        
        let phone = phone1 + phone2 + phone3
        
        UserController.shared.createNewUser(withFirstName: firstName, lastName: lastName, username: username, phone: phone, bio: bio, email: email, password: password) { (success) in
            if success {
                
                self.view.endEditing(true)
                
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
    
    // MARK: - PhoneTextField Auto Advance
    
    @objc func advanceFirstResponder(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        let count = text.count
        
        switch textField {
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
                bioTextField.becomeFirstResponder()
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
            phone1TextField.becomeFirstResponder()
        case phone1TextField:
            phone2TextField.becomeFirstResponder()
        case phone2TextField:
            phone3TextField.becomeFirstResponder()
        case phone3TextField:
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case firstNameTextField:
            firstNameTextField.text = firstNameTextField.text?.trimmingCharacters(in: .whitespaces)
        case lastNameTextField:
            lastNameTextField.text = lastNameTextField.text?.trimmingCharacters(in: .whitespaces)
        case usernameTextField:
            usernameTextField.text = usernameTextField.text?.trimmingCharacters(in: .whitespaces)
        case phone1TextField:
            phone1TextField.text = phone1TextField.text?.trimmingCharacters(in: .whitespaces)
        case phone2TextField:
            phone2TextField.text = phone2TextField.text?.trimmingCharacters(in: .whitespaces)
        case phone3TextField:
            phone3TextField.text = phone3TextField.text?.trimmingCharacters(in: .whitespaces)
        case bioTextField:
            bioTextField.text = bioTextField.text?.trimmingCharacters(in: .whitespaces)
        case emailTextField:
            emailTextField.text = emailTextField.text?.trimmingCharacters(in: .whitespaces)
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
            break
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
