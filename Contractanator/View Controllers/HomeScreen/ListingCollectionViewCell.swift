//
//  ListingCollectionViewCell.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/28/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    // MARK - Properties
    
    var listing: JobListing? {
        didSet {
            setCellColor()
            customUI()
            setLabels()
        }
    }
    
    // MARK - Label Outlets
    
    @IBOutlet var posterNameLabel: UILabel!
    @IBOutlet var jobTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hourlyPayLabel: UILabel!
    
    func setLabels() {
        
        guard let listing = listing else { return }
        
        posterNameLabel.text = "\(listing.firstName) \(listing.lastName)"
        jobTitleLabel.text = listing.title
        descriptionLabel.text = listing.description
        hourlyPayLabel.text = "$\(listing.hourlyPay)/hr"
    }
    
    // MARK - View Outlets
    
    @IBOutlet var customCellView: UIView!
    @IBOutlet var roundedWhiteViewBottom: UIView!
    @IBOutlet var MiddleWhiteViewSquared: UIView!
    
    // Cell Color
    var cellColor: UIColor? = nil
    
    override func awakeFromNib() {
        
    }
    
    func setCellColor() {
        
        switch listing!.jobType {
        case .generalContracting :
            cellColor = UIColor(named: Constants.coolOrange)
        case .electrical :
            cellColor = UIColor(named: Constants.coolBlue)
        case .handyman :
            cellColor = UIColor(named: Constants.urineYellow)
        case .interiorDesign :
            cellColor = UIColor(named: Constants.rudeRed)
        case .homeRenovation :
            cellColor = UIColor(named: Constants.popsiclePurple)
        case .landscaping :
            cellColor = UIColor(named: Constants.grassyGreen)
        }
    }
    
    
    func customUI() {
        
        customCellView.layer.backgroundColor = cellColor?.cgColor
        customCellView.layer.cornerRadius = 22.0
        customCellView.layer.cornerRadius = 22.0
        
        roundedWhiteViewBottom.layer.cornerRadius = 22.0
        
        customCellView.layer.shadowColor = cellColor?.cgColor
        customCellView.layer.shadowRadius = 4
        customCellView.layer.shadowOpacity = 1
        customCellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
    }
    
}
