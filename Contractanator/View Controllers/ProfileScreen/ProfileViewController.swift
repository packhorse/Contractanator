//
//  ProfileViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/29/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    var hasPresentedSignInAlready = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var numberOfListingsLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: Constants.myListingsDidUpdateNotification, object: nil)
        
        UIChanges()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Will need this in your profile view controller
        // Create a reference to our nib
        let collectionViewNib = UINib(nibName: "ListingCollectionViewCell", bundle: nil)
        
        // Register the nib as the cell on our collection view
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: "listingCell")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if presentedViewController == nil {
            
            hasPresentedSignInAlready = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserController.shared.loggedInUser == nil {
            if !hasPresentedSignInAlready {
                let loginVC = storyboard?.instantiateViewController(withIdentifier: "signInVC") as! LogInViewController
                loginVC.isFromProfileVC = true
                
                present(loginVC, animated: true, completion: nil)
                hasPresentedSignInAlready = true
            }
        } else {
            UIChanges()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JobListingController.shared.myListings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as? ListingCollectionViewCell else { return UICollectionViewCell() }
        
        let listing = JobListingController.shared.myListings[indexPath.row]
        
        cell.listing = listing
        
        return cell
    }
    
    @objc func updateViews() {
        
        collectionView.reloadData()
    }
    
    func UIChanges() {
        
        guard let currentUser = UserController.shared.loggedInUser else { return }
        
        nameLabel.text = "\(currentUser.firstName) \(currentUser.lastName)"
        userBioLabel.text = currentUser.bio
        numberOfListingsLabel.text = String(JobListingController.shared.myListings.count)
        phoneLabel.text = currentUser.phone
//        bioTextView.clipsToBounds = true
//        bioTextView.layer.cornerRadius = 10.0
//        bioTextView.layer.borderWidth = 1.0
//        bioTextView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthOfScreen = view.frame.width
        return CGSize(width: (widthOfScreen - 3 * 16) / 2 + 10, height: ((widthOfScreen - 3 * 16) / 2) + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 10, bottom: 50, right: 10)
    }
}





