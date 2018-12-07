//
//  ProfileViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/29/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    @IBOutlet var bioTextView: UITextView!
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
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





