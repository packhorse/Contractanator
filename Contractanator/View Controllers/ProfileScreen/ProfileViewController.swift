//
//  ProfileViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/29/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet var bioTextView: UITextView!
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

    UIChanges()
        
    }
    
    
    func UIChanges() {
        
        bioTextView.clipsToBounds = true
        bioTextView.layer.cornerRadius = 10.0
        bioTextView.layer.borderWidth = 1.0
        bioTextView.layer.borderColor = UIColor.lightGray.cgColor
        
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
