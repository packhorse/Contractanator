//
//  ListingCollectionViewCell.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/28/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var customCellUIView: UIView!
    @IBOutlet var roundedWhiteViewBottom: UIView!
    @IBOutlet var MiddleWhiteViewSquared: UIView!
    
    
    
    override func awakeFromNib() {
        
        customUI()
        
    }
    
    func customUI() {
        
        
        
        
        
        customCellUIView.layer.cornerRadius = 22.0
        customCellUIView.layer.cornerRadius = 22.0
        
        roundedWhiteViewBottom.layer.cornerRadius = 22.0
        
        
        customCellUIView.layer.shadowColor = UIColor.init(named: "CoolBlue")?.cgColor
        customCellUIView.layer.shadowRadius = 3.4
        customCellUIView.layer.shadowOpacity = 5.0
        customCellUIView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
    }
    
}
