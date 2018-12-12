//
//  CollectionViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/28/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: Constants.jobListingsDidUpdateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: Constants.sortedListingsDidUpdateNotification, object: nil)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        // Will need this in your profile view controller
        // Create a reference to our nib
        let collectionViewNib = UINib(nibName: "ListingCollectionViewCell", bundle: nil)
        
        // Register the nib as the cell on our collection view
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: "listingCell")
        
    }
    
    @objc func updateViews() {
        
        self.collectionView.reloadData()
    }
}

extension ListingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if JobListingController.shared.jobTypeFilter == nil &&
            JobListingController.shared.jobCriteriaFilters.count == 0 &&
            JobListingController.shared.maxBudgetHourlyPayFilter == Constants.maxPaySliderAmount {
            return JobListingController.shared.jobListings.count
        } else {
            return JobListingController.shared.sortedListings.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as? ListingCollectionViewCell else { return UICollectionViewCell() }
        
        var listing: JobListing? = nil
        
        if JobListingController.shared.jobTypeFilter == nil &&
            JobListingController.shared.jobCriteriaFilters.count == 0 &&
            JobListingController.shared.maxBudgetHourlyPayFilter == Constants.maxPaySliderAmount {
            listing = JobListingController.shared.jobListings[indexPath.row]
        } else {
            listing = JobListingController.shared.sortedListings[indexPath.row]
        }
        
        cell.listing = listing
        
        return cell
    }
}

extension ListingsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthOfScreen = view.frame.width
        return CGSize(width: (widthOfScreen - 3 * 16) / 2 + 10, height: ((widthOfScreen - 3 * 16) / 2) + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 10, bottom: 50, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var listing: JobListing? = nil
        
        if JobListingController.shared.jobTypeFilter == nil &&
            JobListingController.shared.jobCriteriaFilters.count == 0 &&
            JobListingController.shared.maxBudgetHourlyPayFilter == Constants.maxPaySliderAmount {
            listing = JobListingController.shared.jobListings[indexPath.row]
        } else {
            listing = JobListingController.shared.sortedListings[indexPath.row]
        }
        
        let detailVC = ListingDetailViewController()
        
        detailVC.jobListing = listing
        present(detailVC, animated: true, completion: nil)
    }
}
