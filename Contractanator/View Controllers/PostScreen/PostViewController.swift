//
//  PostViewController.swift
//  Contractanator
//
//  Created by Porter Frazier on 11/29/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var jobDescriptionTextView: UITextView!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    @IBOutlet var button10: UIButton!
    @IBOutlet var button11: UIButton!
    @IBOutlet var button12: UIButton!
    @IBOutlet var postButton: UIButton!
    
    var selectedCriterias: [JobCriteria] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIChanges()
    }
    

    func UIChanges() {
        
        
        nameTextField.layer.cornerRadius = 15.0
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        jobDescriptionTextView.layer.cornerRadius = 18.0
        jobDescriptionTextView.layer.borderWidth = 1.0
        jobDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        button1.layer.cornerRadius = 18.0
        button1.layer.borderWidth = 1.0
        button1.layer.borderColor = UIColor.lightGray.cgColor
        
        button2.layer.cornerRadius = 18.0
        button2.layer.borderWidth = 1.0
        button2.layer.borderColor = UIColor.lightGray.cgColor
        
        button3.layer.cornerRadius = 18.0
        button3.layer.borderWidth = 1.0
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button4.layer.cornerRadius = 18.0
        button4.layer.borderWidth = 1.0
        button4.layer.borderColor = UIColor.lightGray.cgColor
        
        button5.layer.cornerRadius = 18.0
        button5.layer.borderWidth = 1.0
        button5.layer.borderColor = UIColor.lightGray.cgColor
        
        button6.layer.cornerRadius = 18.0
        button6.layer.borderWidth = 1.0
        button6.layer.borderColor = UIColor.lightGray.cgColor
        
        button7.layer.cornerRadius = 18.0
        button7.layer.borderWidth = 1.0
        button7.layer.borderColor = UIColor.lightGray.cgColor
        
        button8.layer.cornerRadius = 18.0
        button8.layer.borderWidth = 1.0
        button8.layer.borderColor = UIColor.lightGray.cgColor
        
        button9.layer.cornerRadius = 18.0
        button9.layer.borderWidth = 1.0
        button9.layer.borderColor = UIColor.lightGray.cgColor
        
        button10.layer.cornerRadius = 18.0
        button10.layer.borderWidth = 1.0
        button10.layer.borderColor = UIColor.lightGray.cgColor
        
        button11.layer.cornerRadius = 18.0
        button11.layer.borderWidth = 1.0
        button11.layer.borderColor = UIColor.lightGray.cgColor
        
        button12.layer.cornerRadius = 18.0
        button12.layer.borderWidth = 1.0
        button12.layer.borderColor = UIColor.lightGray.cgColor
        
        postButton.layer.cornerRadius = 20.0
        postButton.layer.borderWidth = 1.0
        postButton.layer.borderColor = UIColor.gray.cgColor

    }
  
    @IBAction func buttonTapped(_ sender: UIButton) {
        var criteria: JobCriteria?
        
        switch sender.restorationIdentifier {
            case "team":
            criteria = JobCriteria.fullTeam
            
        default:
            print("something went wrong")
            
        }
        
        guard let unwrappedCriteria = criteria else { return }
        if selectedCriterias.contains(unwrappedCriteria) {
            let index = selectedCriterias.firstIndex(of: unwrappedCriteria)
            selectedCriterias.remove(at: index!)
//            sender.backgroundColor =
        } else {
            selectedCriterias.append(unwrappedCriteria)
//            sender.backgroundColor =
        }
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        
        JobListingController.shared.postJobListing(withTitle: <#T##String#>, description: <#T##String#>, jobType: <#T##JobType#>, criteria: selectedCriterias, hourlyPay: <#T##Int#>, zipCode: <#T##Int#>, completion: <#T##(Bool) -> Void#>)
    }
    
    //Slider Code
    
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    @IBAction func SliderValueChange(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        
        sliderValueLabel.text = "$\(currentValue)/hr"
        
        
        
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
