//
//  CellDetailViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/30/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class CellDetailViewController: UIViewController {

    
    @IBOutlet var blueNamePlate: UIView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func UIChanges() {
        
        blueNamePlate.layer.cornerRadius = 20.0
        blueNamePlate.layer.borderWidth = 0
        
        
        
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
