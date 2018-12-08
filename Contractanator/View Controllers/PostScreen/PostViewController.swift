//
//  PostViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/29/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    // MARK: - Properties
    
    // These variables change based on the selection by the user
    var selectedJobType: JobType?
    var selectedJobTypeButton: UIButton?
    var vcThemeColor: UIColor? = UIColor.lightGray
    
    var selectedCriterias: [JobCriteria] = []
    var selectedCriteriaButtons: [UIButton] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var jobTypeButton1: UIButton!
    @IBOutlet var jobTypeButton2: UIButton!
    @IBOutlet var jobTypeButton3: UIButton!
    @IBOutlet var jobTypeButton4: UIButton!
    @IBOutlet var jobTypeButton5: UIButton!
    @IBOutlet var jobTypeButton6: UIButton!
    @IBOutlet var criteriaButton1: UIButton!
    @IBOutlet var criteriaButton2: UIButton!
    @IBOutlet var criteriaButton3: UIButton!
    @IBOutlet var criteriaButton4: UIButton!
    @IBOutlet var criteriaButton5: UIButton!
    @IBOutlet var criteriaButton6: UIButton!
    @IBOutlet var postButton: UIButton!
    @IBOutlet weak var paySliderLabel: UILabel!
    @IBOutlet var paySlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIChanges()
        self.hideKeyboardWhenTappedAround()
        
        // Delegates
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        
        // Keyboard show and hide notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIWindow.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func jobTypeButtonTapped(_ sender: UIButton) {
        
        var jobType: JobType?
        
        switch sender.restorationIdentifier {
        case "contracting":
            jobType = JobType.generalContracting
            vcThemeColor = UIColor(named: "CoolOrange")
        case "electrical":
            jobType = JobType.electrical
            vcThemeColor = UIColor(named: "CoolBlue")
        case "handyman":
            jobType = JobType.handyman
            vcThemeColor = UIColor(named: "UrineYellow")
        case "interiorDesign":
            jobType = JobType.interiorDesign
            vcThemeColor = UIColor(named: "RudeRed")
        case "homeRenno":
            jobType = JobType.homeRenovation
            vcThemeColor = UIColor(named: "PopsiclePurple")
        case "landscaping":
            jobType = JobType.landscaping
            vcThemeColor = UIColor(named: "GrassyGreen")
        default:
            print("Something went wrong!")
        }

        if jobType != selectedJobType {
            
            // Updates the theme accross the entire view
            turnOnButtonColor(sender)
            updateVCThemeColor()
            
            // Turn off the color on the previously selected button
            turnOffButtonColor(selectedJobTypeButton)
            
            // Make the sender/tapped button the new selected button
            selectedJobTypeButton = sender
            selectedJobType = jobType
        }
    }
    
    @IBAction func criteriaButtonTapped(_ sender: UIButton) {
        
        var criteria: JobCriteria?
        
        switch sender.restorationIdentifier {
        case "team":
            criteria = JobCriteria.fullTeam
        case "quality":
            criteria = JobCriteria.highQuality
        case "specalized":
            criteria = JobCriteria.specialized
        case "fast":
            criteria = JobCriteria.fast
        case "experienced":
            criteria = JobCriteria.experienced
        case "affordable":
            criteria = JobCriteria.affordable
            
        default:
            print("something went wrong")
        }
        
        guard let unwrappedCriteria = criteria else { return }
        if selectedCriterias.contains(unwrappedCriteria) {
            let index = selectedCriterias.firstIndex(of: unwrappedCriteria)
            selectedCriterias.remove(at: index!)
            selectedCriteriaButtons.remove(at: index!)
            turnOffButtonColor(sender)
        } else {
            // If three types are selected, remove the last one and replace it with the new selection
            if selectedCriterias.count == 3 {
                turnOffButtonColor(selectedCriteriaButtons[2])
                selectedCriterias.remove(at: 2)
                selectedCriteriaButtons.remove(at: 2)
            }
            selectedCriterias.append(unwrappedCriteria)
            selectedCriteriaButtons.append(sender)
            turnOnButtonColor(sender)
        }
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        
        guard let title = titleTextField.text, !title.isEmpty,
            let description = descriptionTextView.text, !description.isEmpty,
            let jobType = selectedJobType,
            selectedCriterias.count == 3
            else { print("Missing info") ; return  }
        
        let hourlyPay = Int(paySlider.value)
        let zipCode = "84041"
        
        if (UserController.shared.loggedInUser != nil) {
            JobListingController.shared.postJobListing(withTitle: title, description: description, jobType: jobType,
                                                       criteria: selectedCriterias, hourlyPay: hourlyPay,
                                                       zipCode: zipCode) { (success) in
                if success {
                    
                    self.tabBarController?.selectedIndex = 2
                    self.resetVC()
                } else {
                    print("WompWompWompppp...")
                }
            }
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signUpVC = storyboard.instantiateViewController(withIdentifier: "signInVC") as! LogInViewController
            signUpVC.themeColor = vcThemeColor
            self.present(signUpVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        
        paySliderLabel.text = "$\(currentValue)/hr"
    }
    
    // MARK: - Functions
    
    fileprivate func turnOnButtonColor(_ sender: UIButton) {
        
        // Updates the view for the button tapped by the User
        sender.backgroundColor = vcThemeColor
        sender.layer.shadowColor = vcThemeColor?.cgColor
        sender.layer.shadowRadius = 4
        sender.layer.shadowOpacity = 1
        sender.layer.shadowOffset = CGSize(width: 0, height: 0)
        sender.layer.borderColor = vcThemeColor?.cgColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    fileprivate func turnOffButtonColor(_ button: UIButton?) {
        
        guard let button = button else { return }
        // Restores the view for the button to its default
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.borderColor = UIColor.gray.cgColor
        
        if button != selectedJobTypeButton {
            
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    fileprivate func updateVCThemeColor() {
        self.navigationController?.navigationBar.barTintColor = vcThemeColor
        _ = selectedCriteriaButtons.map({ turnOnButtonColor($0) })
        paySlider.tintColor = vcThemeColor
        postButton.backgroundColor = vcThemeColor
        postButton.layer.shadowColor = vcThemeColor?.cgColor
        postButton.layer.borderColor = vcThemeColor?.cgColor
        postButton.layer.shadowOpacity = 2.0
        postButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        postButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    fileprivate func UIChanges() {
        
        // Title Text Field
        titleTextField.layer.cornerRadius = 21.0
        titleTextField.layer.borderWidth = 1.0
        titleTextField.layer.borderColor = UIColor.lightGray.cgColor
        titleTextField.setLeftPaddingPoints(15)
        
        // Description Text View
        descriptionTextView.layer.cornerRadius = 18.0
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 5)
        
        // Buttons
        jobTypeButton1.layer.cornerRadius = 18.0
        jobTypeButton1.layer.borderWidth = 1.0
        jobTypeButton1.layer.borderColor = UIColor.gray.cgColor
        jobTypeButton1.titleLabel?.adjustsFontSizeToFitWidth = true
        
        jobTypeButton2.layer.cornerRadius = 18.0
        jobTypeButton2.layer.borderWidth = 1.0
        jobTypeButton2.layer.borderColor = UIColor.gray.cgColor
        jobTypeButton2.titleLabel?.adjustsFontSizeToFitWidth = true
        
        jobTypeButton3.layer.cornerRadius = 18.0
        jobTypeButton3.layer.borderWidth = 1.0
        jobTypeButton3.layer.borderColor = UIColor.gray.cgColor
        jobTypeButton3.titleLabel?.adjustsFontSizeToFitWidth = true
        
        jobTypeButton4.layer.cornerRadius = 18.0
        jobTypeButton4.layer.borderWidth = 1.0
        jobTypeButton4.layer.borderColor = UIColor.gray.cgColor
        jobTypeButton4.titleLabel?.adjustsFontSizeToFitWidth = true
        
        jobTypeButton5.layer.cornerRadius = 18.0
        jobTypeButton5.layer.borderWidth = 1.0
        jobTypeButton5.layer.borderColor = UIColor.gray.cgColor
        jobTypeButton5.titleLabel?.adjustsFontSizeToFitWidth = true
        
        jobTypeButton6.layer.cornerRadius = 18.0
        jobTypeButton6.layer.borderWidth = 1.0
        jobTypeButton6.layer.borderColor = UIColor.gray.cgColor
        jobTypeButton6.titleLabel?.adjustsFontSizeToFitWidth = true
        
        criteriaButton1.layer.cornerRadius = 18.0
        criteriaButton1.layer.borderWidth = 1.0
        criteriaButton1.layer.borderColor = UIColor.lightGray.cgColor
        criteriaButton1.titleLabel?.adjustsFontSizeToFitWidth = true
        
        criteriaButton2.layer.cornerRadius = 18.0
        criteriaButton2.layer.borderWidth = 1.0
        criteriaButton2.layer.borderColor = UIColor.lightGray.cgColor
        criteriaButton2.titleLabel?.adjustsFontSizeToFitWidth = true
        
        criteriaButton3.layer.cornerRadius = 18.0
        criteriaButton3.layer.borderWidth = 1.0
        criteriaButton3.layer.borderColor = UIColor.lightGray.cgColor
        criteriaButton3.titleLabel?.adjustsFontSizeToFitWidth = true
        
        criteriaButton4.layer.cornerRadius = 18.0
        criteriaButton4.layer.borderWidth = 1.0
        criteriaButton4.layer.borderColor = UIColor.lightGray.cgColor
        criteriaButton4.titleLabel?.adjustsFontSizeToFitWidth = true
        
        criteriaButton5.layer.cornerRadius = 18.0
        criteriaButton5.layer.borderWidth = 1.0
        criteriaButton5.layer.borderColor = UIColor.lightGray.cgColor
        criteriaButton5.titleLabel?.adjustsFontSizeToFitWidth = true
        
        criteriaButton6.layer.cornerRadius = 18.0
        criteriaButton6.layer.borderWidth = 1.0
        criteriaButton6.layer.borderColor = UIColor.lightGray.cgColor
        criteriaButton6.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // Pay Slider
        paySlider.tintColor = UIColor.gray
        
        // Post Button
        postButton.layer.cornerRadius = 24.0
        postButton.layer.borderWidth = 1.0
        postButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    fileprivate func resetVC() {
        
        vcThemeColor = UIColor.lightGray
        turnOffButtonColor(selectedJobTypeButton)
        updateVCThemeColor()
        navigationController?.navigationBar.barTintColor = UIColor.white
        let _ = selectedCriteriaButtons.map({ turnOffButtonColor($0) })
        
        selectedJobType = nil
        selectedJobTypeButton = nil
        
        selectedCriterias = []
        selectedCriteriaButtons = []
        
        titleTextField.text = ""
        descriptionTextView.text = ""
        
        paySlider.value = 30
        
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

// MARK: - Extensions

extension PostViewController: UITextFieldDelegate, UITextViewDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.descriptionTextView.becomeFirstResponder()
        
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        let scrollToPoint = Int(descriptionTextView.frame.minY) - 50
        
        UIView.animate(withDuration: 0.1) {
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: scrollToPoint)
        }
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            descriptionTextView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
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

extension UIViewController {
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
