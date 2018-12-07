//
//  SearchScreenViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/29/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    
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
    @IBOutlet var paySliderLabel: UILabel!
    @IBOutlet weak var paySlider: UISlider!
    @IBOutlet var postButton: UIButton!

    var selectedJobTypeButton: UIButton?
    var vcThemeColor: UIColor? = UIColor.lightGray
    
    var selectedCriterias = JobListingController.shared.jobCriteriaFilter
    var selectedCriteriaButtons: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changedUI()
    }
    
    
    @IBAction func SliderBar(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        JobListingController.shared.minimumPayFilter = currentValue
        paySliderLabel.text = "$\(currentValue)/hr"
        
    }
    
    
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
    
    
    
    
    @IBAction func jobTypeButtonSelected(_ sender: UIButton) {
        
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
            print("Something went wrong when searching")
        }
        
        if jobType != JobListingController.shared.jobTypeFilter {
            
            // Updates the theme accross the entire view
            turnOnButtonColor(sender)
            updateVCThemeColor()
            
            // Turn off the color on the previously selected button
            turnOffButtonColor(selectedJobTypeButton)
            
            // Make the sender/tapped button the new selected button
            selectedJobTypeButton = sender
            JobListingController.shared.jobTypeFilter = jobType
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
            selectedCriterias.append(unwrappedCriteria)
            selectedCriteriaButtons.append(sender)
            turnOnButtonColor(sender)
        }
    }
    
    func changedUI() {
        
        // Buttons
        jobTypeButton1.layer.cornerRadius = 18.0
        jobTypeButton1.layer.borderWidth = 1.0
        jobTypeButton1.layer.borderColor = UIColor.lightGray.cgColor
        
        jobTypeButton2.layer.cornerRadius = 18.0
        jobTypeButton2.layer.borderWidth = 1.0
        jobTypeButton2.layer.borderColor = UIColor.lightGray.cgColor
        
        jobTypeButton3.layer.cornerRadius = 18.0
        jobTypeButton3.layer.borderWidth = 1.0
        jobTypeButton3.layer.borderColor = UIColor.lightGray.cgColor
        
        jobTypeButton4.layer.cornerRadius = 18.0
        jobTypeButton4.layer.borderWidth = 1.0
        jobTypeButton4.layer.borderColor = UIColor.lightGray.cgColor
        
        jobTypeButton5.layer.cornerRadius = 18.0
        jobTypeButton5.layer.borderWidth = 1.0
        jobTypeButton5.layer.borderColor = UIColor.lightGray.cgColor
        
        jobTypeButton6.layer.cornerRadius = 18.0
        jobTypeButton6.layer.borderWidth = 1.0
        jobTypeButton6.layer.borderColor = UIColor.lightGray.cgColor
        
        criteriaButton1.layer.cornerRadius = 18.0
        criteriaButton1.layer.borderWidth = 1.0
        criteriaButton1.layer.borderColor = UIColor.lightGray.cgColor
        
        criteriaButton2.layer.cornerRadius = 18.0
        criteriaButton2.layer.borderWidth = 1.0
        criteriaButton2.layer.borderColor = UIColor.lightGray.cgColor
        
        criteriaButton3.layer.cornerRadius = 18.0
        criteriaButton3.layer.borderWidth = 1.0
        criteriaButton3.layer.borderColor = UIColor.lightGray.cgColor
        
        criteriaButton4.layer.cornerRadius = 18.0
        criteriaButton4.layer.borderWidth = 1.0
        criteriaButton4.layer.borderColor = UIColor.lightGray.cgColor
        
        criteriaButton5.layer.cornerRadius = 18.0
        criteriaButton5.layer.borderWidth = 1.0
        criteriaButton5.layer.borderColor = UIColor.lightGray.cgColor
        
        criteriaButton6.layer.cornerRadius = 18.0
        criteriaButton6.layer.borderWidth = 1.0
        criteriaButton6.layer.borderColor = UIColor.lightGray.cgColor
        
        postButton.layer.cornerRadius = 21.0
        postButton.layer.borderWidth = 1.0
        postButton.layer.borderColor = UIColor.gray.cgColor
        
        paySlider.tintColor = UIColor.gray
    }
}
