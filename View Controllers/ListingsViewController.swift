//
//  CollectionViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/28/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {
    
    @IBOutlet var viewBehindContractanator: UIView!
    @IBOutlet var viewBehindNavBar: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        
        // Will need this in your profile view controller
        // Create a reference to our nib
        let collectionViewNib = UINib(nibName: "ListingCollectionViewCell", bundle: nil)
        
        // Register the nib as the cell on our collection view
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: "listingCell")
        
        
        UIChanges()
    }
    
    
    func UIChanges() {
        
        //Contractanator View
        viewBehindContractanator.layer.shadowOpacity = 0.4
        viewBehindContractanator.layer.shadowOffset = CGSize(width: -0.5, height: 1)
        viewBehindContractanator.layer.shadowRadius = 1
        viewBehindContractanator.layer.shadowColor = UIColor.darkGray.cgColor
        
        
        //View behind where the navigation bar goes on the bottom
        viewBehindNavBar.layer.shadowOpacity = 0.4
        viewBehindNavBar.layer.shadowOffset = CGSize(width: 0.5, height: -1)
        viewBehindNavBar.layer.shadowRadius = 1
        viewBehindNavBar.layer.shadowColor = UIColor.darkGray.cgColor
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ListingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as? ListingCollectionViewCell else { return UICollectionViewCell() }
        
        
        return cell
    }
    
}
