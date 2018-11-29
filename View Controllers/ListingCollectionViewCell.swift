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
    @IBOutlet var whiteSquareView: UIView!
    @IBOutlet var whiteRoundedSquareView: UIView!
    
    
    
    
    
    override func awakeFromNib() {
        
        customUI()
    }
    
    func customUI() {
        
        customCellUIView.layer.cornerRadius = 22
        customCellUIView.backgroundColor = UIColor.init(named: "CoolBlue")
        
        customCellUIView.layer.shadowColor = UIColor.init(named: "CoolBlue")?.cgColor
        customCellUIView.layer.shadowRadius = 3.4
        customCellUIView.layer.shadowOpacity = 100.0
        customCellUIView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        whiteRoundedSquareView.layer.cornerRadius = 22
        
    }
    
}
