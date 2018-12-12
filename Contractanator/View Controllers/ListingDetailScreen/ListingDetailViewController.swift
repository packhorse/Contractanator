//
//  ListingDetailViewController.swift
//  Contractanator
//
//  Created by Travis Chapman on 12/11/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ListingDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var jobListing: JobListing? {
        didSet {
            updateViews()
        }
    }
    
    var phoneCallURL: URL? = nil
    var phoneTextURL: URL? = nil
    
    var themeColor: UIColor? = UIColor.lightGray
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var posterNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hourlyPayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var smallHourlyPayLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var qualitiesLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var reportListingButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide Buttons Until Network Call Gets User object
        callButton.isHidden = true
        textButton.isHidden = true
        
        // Get the user object for the poster phone number/profile link
        setupButtons()
    }

    // MARK: - Actions
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reportListingButtonTapped(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: "Are you sure?", message: "By clicking \"Report\", you are reporting this listing for review by our moderators and it may result in the listing being removed.", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let report = UIAlertAction(title: "Report", style: .destructive) { (_) in
            
            JobListingController.shared.reportJobListing(withListingID: self.jobListing!.listingID, completion: { (successful) in
                if successful {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
        
        alertVC.addAction(cancel)
        alertVC.addAction(report)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    fileprivate func setupButtons() {
        
        guard let username = jobListing?.username else { return }
        
        UserController.shared.fetchUserProfile(withUsername: username) { (user) in
            guard let postingUser = user else { return }
            
            let phoneNumber = postingUser.phone
            self.phoneCallURL = URL(string: "tel://\(phoneNumber)")
            self.phoneTextURL = URL(string: "sms://\(phoneNumber)")
            
            // Setup Targets
            self.callButton.addTarget(self, action: #selector(self.callPoster), for: .touchUpInside)
            self.textButton.addTarget(self, action: #selector(self.textPoster), for: .touchUpInside)
            
            // Unhide the action buttons
            self.callButton.isHidden = false
            self.textButton.isHidden = false
            }
    }
    
    fileprivate func updateViews() {
        
        guard let listing = jobListing else { return }
        
        loadViewIfNeeded()
        posterNameLabel.text = "\(listing.firstName) \(listing.lastName)"
        titleLabel.text = listing.title
        hourlyPayLabel.text = "$\(listing.hourlyPay)/hr"
        descriptionLabel.text = listing.description
        smallHourlyPayLabel.text = "$\(listing.hourlyPay)/hr"
        jobTypeLabel.text = getJobTypeAsString()
        qualitiesLabel.text = getQualitiesAsString()
        datePostedLabel.text = listing.timestamp.asString
        
        setThemeColor()
    }
    
    fileprivate func setThemeColor() {
        
        guard let listing = jobListing else { return }
        
        switch listing.jobType {
        case .generalContracting :
            themeColor = UIColor(named: Constants.coolOrange)
        case .electrical :
            themeColor = UIColor(named: Constants.coolBlue)
        case .handyman :
            themeColor = UIColor(named: Constants.urineYellow)
        case .interiorDesign :
            themeColor = UIColor(named: Constants.rudeRed)
        case .homeRenovation :
            themeColor = UIColor(named: Constants.popsiclePurple)
        case .landscaping :
            themeColor = UIColor(named: Constants.grassyGreen)
        }
        
        backgroundColorView.backgroundColor = themeColor
        reportListingButton.setTitleColor(themeColor, for: .normal)
        
        // Call and Profile buttons
        callButton.layer.cornerRadius = callButton.frame.height / 2
        callButton.layer.borderWidth = 1.0
        callButton.backgroundColor = themeColor
        callButton.layer.borderColor = themeColor?.cgColor
        callButton.layer.shadowColor = themeColor?.cgColor
        callButton.layer.shadowOpacity = 2.0
        callButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        callButton.setTitleColor(UIColor.white, for: .normal)
        
        textButton.layer.cornerRadius = callButton.frame.height / 2
        textButton.layer.borderWidth = 1.0
        textButton.backgroundColor = themeColor
        textButton.layer.borderColor = themeColor?.cgColor
        textButton.layer.shadowColor = themeColor?.cgColor
        textButton.layer.shadowOpacity = 2.0
        textButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        textButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    fileprivate func getQualitiesAsString() -> String {
        
        guard let listing = jobListing else { return "" }
        
        var qualities = [String]()
        
        for criteria in listing.criteria {
            
            switch criteria {
            case .fullTeam :
                qualities.append("Team")
            case .fast :
                qualities.append("Fast")
            case .affordable :
                qualities.append("Affordable")
            case .experienced :
                qualities.append("Experienced")
            case .highQuality :
                qualities.append("High Quality")
            case .specialized :
                qualities.append("Specialized")
            }
        }
        
        return qualities.joined(separator: ", ")
    }
    
    fileprivate func getJobTypeAsString() -> String {
        
        guard let listing = jobListing else { return "" }
        
        switch listing.jobType {
        case .generalContracting :
            return "General Contractor"
        case .electrical :
            return "Electrician"
        case .handyman :
            return "Handyman"
        case .interiorDesign :
            return "Interior Designer"
        case .homeRenovation :
            return "Home Renovation Specialist"
        case .landscaping :
            return "Landscaper/Gardener"
        }
    }
    
    @objc fileprivate func callPoster() {
        
        guard let phoneCallURL = phoneCallURL else { return }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(phoneCallURL)
        } else {
            UIApplication.shared.openURL(phoneCallURL)
        }
    }
    
    @objc fileprivate func textPoster() {
        
        guard let phoneTextURL = phoneTextURL else { return }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(phoneTextURL)
        } else {
            UIApplication.shared.openURL(phoneTextURL)
        }
    }
}

extension Date {
    
    var asString: String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
