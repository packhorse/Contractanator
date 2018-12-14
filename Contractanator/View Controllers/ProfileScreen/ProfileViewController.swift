//
//  ProfileViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/29/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var numberOfListingsLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: Constants.myListingsDidUpdateNotification, object: nil)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Will need this in your profile view controller
        // Create a reference to our nib
        let collectionViewNib = UINib(nibName: "ListingCollectionViewCell", bundle: nil)
        
        // Register the nib as the cell on our collection view
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: "listingCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIChanges()
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        
        presentActionSheet()
    }
    
    // MARK: - Collection View Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JobListingController.shared.myListings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as? ListingCollectionViewCell else { return UICollectionViewCell() }
        
        let listing = JobListingController.shared.myListings[indexPath.row]
        
        cell.listing = listing
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthOfScreen = view.frame.width
        return CGSize(width: (widthOfScreen - 3 * 16) / 2 + 10, height: ((widthOfScreen - 3 * 16) / 2) + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 10, bottom: 50, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var listing: JobListing? = nil
        
        listing = JobListingController.shared.myListings[indexPath.row]
        
        let detailVC = ListingDetailViewController()
        
        detailVC.jobListing = listing
        present(detailVC, animated: true, completion: nil)
    }
    
    // MARK: - UI Functions
    
    @objc func updateViews() {
        
        collectionView.reloadData()
    }
    
    func UIChanges() {
        
        guard let currentUser = UserController.shared.loggedInUser else { return }
        
        navigationItem.title = "\(currentUser.firstName) \(currentUser.lastName)"
        userBioLabel.text = currentUser.bio
        numberOfListingsLabel.text = String(JobListingController.shared.myListings.count)
        phoneLabel.text = currentUser.phone
    }
    
    // MARK: - Other Functions
    
    fileprivate func logoutUser() {
        
        UserController.shared.logoutUser { (successfulLogout) in
            if successfulLogout {
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    func presentActionSheet() {
        
        let actionSheetVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logout = UIAlertAction(title: "Logout", style: .destructive) { (_) in
            self.logoutUser()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetVC.addAction(logout)
        actionSheetVC.addAction(cancel)
        
        present(actionSheetVC, animated: true, completion: nil)
    }
}




