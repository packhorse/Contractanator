//
//  SearchScreenViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/29/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedJobTypeButton: UIButton?
    var selectedCriteriaButtons: [UIButton] = []
    var vcThemeColor: UIColor? = UIColor.lightGray
    
    // MARK: - Outlets
    
    @IBOutlet weak var jobTypeButton1: UIButton!
    @IBOutlet weak var jobTypeButton2: UIButton!
    @IBOutlet weak var jobTypeButton3: UIButton!
    @IBOutlet weak var jobTypeButton4: UIButton!
    @IBOutlet weak var jobTypeButton5: UIButton!
    @IBOutlet weak var jobTypeButton6: UIButton!
    @IBOutlet weak var criteriaButton1: UIButton!
    @IBOutlet weak var criteriaButton2: UIButton!
    @IBOutlet weak var criteriaButton3: UIButton!
    @IBOutlet weak var criteriaButton4: UIButton!
    @IBOutlet weak var criteriaButton5: UIButton!
    @IBOutlet weak var criteriaButton6: UIButton!
    @IBOutlet weak var paySliderLabel: UILabel!
    @IBOutlet weak var paySlider: UISlider!
    @IBOutlet weak var applyFiltersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: - Actions
    
    @IBAction func SliderBar(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        JobListingController.shared.maxBudgetHourlyPayFilter = currentValue
        paySliderLabel.text = "$\(currentValue)/hr"
        
    }
    
    @IBAction func applyFiltersButtonTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func jobTypeButtonSelected(_ sender: UIButton) {
        
        var jobType: JobType?
        
        switch sender.restorationIdentifier {
            
        case "contracting":
            jobType = JobType.generalContracting
            vcThemeColor = UIColor(named: Constants.coolOrange)
        case "electrical":
            jobType = JobType.electrical
            vcThemeColor = UIColor(named: Constants.coolBlue)
        case "handyman":
            jobType = JobType.handyman
            vcThemeColor = UIColor(named: Constants.urineYellow)
        case "interiorDesign":
            jobType = JobType.interiorDesign
            vcThemeColor = UIColor(named: Constants.rudeRed)
        case "homeRenno":
            jobType = JobType.homeRenovation
            vcThemeColor = UIColor(named: Constants.popsiclePurple)
        case "landscaping":
            jobType = JobType.landscaping
            vcThemeColor = UIColor(named: Constants.grassyGreen)
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
        } else {
            
            // Update model controller filters
            JobListingController.shared.jobTypeFilter = nil
            
            selectedJobTypeButton = nil
            turnOffButtonColor(sender)
            turnOffColorTheme()
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
        
        if JobListingController.shared.jobCriteriaFilters.contains(unwrappedCriteria) {
            let index = JobListingController.shared.jobCriteriaFilters.firstIndex(of: unwrappedCriteria)
            JobListingController.shared.jobCriteriaFilters.remove(at: index!)
            selectedCriteriaButtons.remove(at: index!)
            turnOffButtonColor(sender)
        } else {
            if JobListingController.shared.jobCriteriaFilters.count == 3 {
                turnOffButtonColor(selectedCriteriaButtons[2])
                JobListingController.shared.jobCriteriaFilters.remove(at: 2)
                selectedCriteriaButtons.remove(at: 2)
            }
            JobListingController.shared.jobCriteriaFilters.append(unwrappedCriteria)
            selectedCriteriaButtons.append(sender)
            turnOnButtonColor(sender)
        }
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
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        if button != selectedJobTypeButton {
            
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    fileprivate func turnOffColorTheme() {
        
        vcThemeColor = UIColor.lightGray
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        _ = selectedCriteriaButtons.map({ turnOnButtonColor($0) })
        paySlider.tintColor = vcThemeColor
        applyFiltersButton.backgroundColor = vcThemeColor
        applyFiltersButton.layer.shadowColor = vcThemeColor?.cgColor
        applyFiltersButton.layer.borderColor = vcThemeColor?.cgColor
        applyFiltersButton.layer.shadowOpacity = 2.0
        applyFiltersButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    
    fileprivate func updateVCThemeColor() {
        self.navigationController?.navigationBar.barTintColor = vcThemeColor
        _ = selectedCriteriaButtons.map({ turnOnButtonColor($0) })
        paySlider.tintColor = vcThemeColor
        applyFiltersButton.backgroundColor = vcThemeColor
        applyFiltersButton.layer.shadowColor = vcThemeColor?.cgColor
        applyFiltersButton.layer.borderColor = vcThemeColor?.cgColor
        applyFiltersButton.layer.shadowOpacity = 2.0
        applyFiltersButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        applyFiltersButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    
    
    func setupUIFor(_ button: UIButton) {
        
        button.layer.cornerRadius = 18.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    fileprivate func turnOnExistingJobTypeFilterButton() {

        if let jobType = JobListingController.shared.jobTypeFilter {
            
            var selectedButton: UIButton? = nil
            
            switch jobType {
            case .generalContracting :
                vcThemeColor = UIColor(named: Constants.coolOrange)
                selectedButton = jobTypeButton1
            case .electrical :
                vcThemeColor = UIColor(named: Constants.coolBlue)
                selectedButton = jobTypeButton2
            case .handyman :
                vcThemeColor = UIColor(named: Constants.urineYellow)
                selectedButton = jobTypeButton3
            case .interiorDesign :
                vcThemeColor = UIColor(named: Constants.rudeRed)
                selectedButton = jobTypeButton4
            case .homeRenovation :
                vcThemeColor = UIColor(named: Constants.popsiclePurple)
                selectedButton = jobTypeButton5
            case .landscaping :
                vcThemeColor = UIColor(named: Constants.grassyGreen)
                selectedButton = jobTypeButton6
            }
            
            selectedJobTypeButton = selectedButton
            turnOnButtonColor(selectedButton!)
            updateVCThemeColor()
            
        }
    }
    
    fileprivate func turnOnExistingCriteriaButtons() {
        for criteria in JobListingController.shared.jobCriteriaFilters {
            
            var button: UIButton? = nil
            
            switch criteria {
            case .fullTeam:
                selectedCriteriaButtons.append(criteriaButton1)
                button = criteriaButton1
            case .highQuality:
                selectedCriteriaButtons.append(criteriaButton2)
                button = criteriaButton2
            case .specialized:
                selectedCriteriaButtons.append(criteriaButton3)
                button = criteriaButton3
            case .fast:
                selectedCriteriaButtons.append(criteriaButton4)
                button = criteriaButton4
            case .experienced:
                selectedCriteriaButtons.append(criteriaButton5)
                button = criteriaButton5
            case .affordable:
                selectedCriteriaButtons.append(criteriaButton6)
                button = criteriaButton6
            }
            
            turnOnButtonColor(button!)
        }
    }
    
    func updateUI() {
        
        
        // Setup Toggle Buttons
        setupUIFor(jobTypeButton1)
        setupUIFor(jobTypeButton2)
        setupUIFor(jobTypeButton3)
        setupUIFor(jobTypeButton4)
        setupUIFor(jobTypeButton5)
        setupUIFor(jobTypeButton6)
        
        setupUIFor(criteriaButton1)
        setupUIFor(criteriaButton2)
        setupUIFor(criteriaButton3)
        setupUIFor(criteriaButton4)
        setupUIFor(criteriaButton5)
        setupUIFor(criteriaButton6)
        
        // Setup Apply Filters Button
        applyFiltersButton.layer.cornerRadius = 21.0
        applyFiltersButton.layer.borderWidth = 1.0
        applyFiltersButton.layer.borderColor = UIColor.lightGray.cgColor
        
        paySlider.tintColor = UIColor.lightGray
        paySlider.value = Float(JobListingController.shared.maxBudgetHourlyPayFilter)
        paySliderLabel.text = "$\(String(Int(paySlider.value)))/hr"
        
        // Setup previously selected filter buttons in session, if any
        turnOnExistingJobTypeFilterButton()
        turnOnExistingCriteriaButtons()
    }
}
