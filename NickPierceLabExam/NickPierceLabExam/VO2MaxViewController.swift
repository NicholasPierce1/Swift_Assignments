//
//  ViewController.swift
//  NickPierceLabExam
//
//  Created by Pierce,Nicholas A on 4/16/19.
//  Copyright © 2019 Pierce,Nicholas A. All rights reserved.
//

import UIKit

// enum to hold possible error entries from user
enum InvalidEntry: String{
    case negativeWeight = "Weight was negative. Please Try Again"
    case negativeAge = "Age was negative. Please Try Again"
    case outOfRangeSex = "Sex can be 1 or 0. Please Try Again or consult with UCLU"
    case negativeTime = "Come on, you're not that fast... try a postive time for a change"
    case negativeHeartRate = "Are you trying to ask for help..? Try a positive heart rate..."
    case cannotConvert = "Empty field OR spelled word. Enter '8' for example."
    case negativeReturn = "Negative VO2... come on man!"
}

class VO2MaxViewController: UIViewController {
    
    // enumerates outlets to retain user input
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var sex: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var heartRate: UITextField!
    
    // outlets to display results
    
    @IBOutlet weak var calculatedVO2Max: UILabel!
    
    @IBOutlet weak var vO2Classification: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // solicits model to return VO2 Max and its label
    @IBAction func calculateVO2Max(_ sender: Any?){
        
        // corroborates input is correct
        
        // weight
        guard let weight: Double = Double(weight.text!) else {
            displayAlert(message: InvalidEntry.cannotConvert.rawValue)
            return
        }
        if weight < 0 {
            displayAlert(message: InvalidEntry.negativeWeight.rawValue)
        }
        
        // age
        guard let age = Int(age.text!) else {
            displayAlert(message: InvalidEntry.cannotConvert.rawValue)
            return
        }
        if age < 0 {
            displayAlert(message: InvalidEntry.negativeAge.rawValue)
        }
        
        // sex
        guard let sex = Int(sex.text!) else {
            displayAlert(message: InvalidEntry.cannotConvert.rawValue)
            return
        }
            if sex < 0 {
                displayAlert(message: InvalidEntry.outOfRangeSex.rawValue)
            }
        
        
        // time
        guard let time = Double(time.text!) else {
            displayAlert(message: InvalidEntry.cannotConvert.rawValue)
            return
        }
        if time < 0 {
            displayAlert(message: InvalidEntry.negativeTime.rawValue)
        }
        
        // heart  rate
        guard let heartRate = Double(heartRate.text!) else {
            displayAlert(message: InvalidEntry.cannotConvert.rawValue)
            return
        }
        if heartRate < 0 {
            displayAlert(message: InvalidEntry.negativeHeartRate.rawValue)
        }
        
        // calls method and updates labels
        let vO2Max: Double = SportsGuru.shared.vO2Max(weight: weight, age: age, sex: sex, time: time, heartRate: heartRate)
        
        if vO2Max <= 0 {
            displayAlert(message: InvalidEntry.negativeReturn.rawValue)
            return
        }
        
        calculatedVO2Max.text = String(format: "%.1f", vO2Max)
        vO2Classification.text = SportsGuru.shared.vO2MaxClassification(vO2Max)
        
        vO2Classification.textColor = colorToDisplay(classification: vO2Classification.text!)
        
    }

    // displays UIAlertController to inform of faulty input
    private func displayAlert(message: String) -> Void{
        // creates UIAlertController
        let alertControl = UIAlertController(title: "Invalid Input", message: message, preferredStyle: UIAlertController.Style.alert)
        
        // creates action handler
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        // appends alert controller to action
        alertControl.addAction(alertAction)
        
        // presents
        self.present(alertControl, animated: true, completion: nil)
    }
    
    // amends color of classification in accordance to the vO2 classification
    private func colorToDisplay(classification: String) -> UIColor {
        switch classification{
        case "Excellent": return UIColor.yellow
        case "Good": return UIColor.blue
        case "Above average": return UIColor.green
        default: return UIColor.black
        }
    }
}

