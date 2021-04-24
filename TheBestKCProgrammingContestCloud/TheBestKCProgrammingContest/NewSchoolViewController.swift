//
//  NewSchoolViewController.swift
//  TheBestKCProgrammingContest
//
//  Created by Nick Pierce on 3/12/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class NewSchoolViewController: UIViewController {
    
    // property holding parent ViewController
    var presented: SchoolsTableViewController!
    
    // enumerates outlets
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var coach: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // action to dimiss all data comprised in textfields and transitions back to modally presented ViewController
    @IBAction func dismisses(_ sender: Any){
        
        // invokes dismiss method
        self.dismiss(animated: true) {
            // clears any data in textfields
            self.name.text = ""
            self.coach.text = ""
        }
    }
    
    // renders new School and appends to Schools's shared instance while dismissing modally
    @IBAction func done(_ sender: Any){
        
        // starts animating and bars subsequent user interaction
        self.presented.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // holding references to passed args for background thread
        let name = self.name.text!
        let coach = self.coach.text!
        
        // invokes dismiss
        self.dismiss(animated: true) {
            
            DispatchQueue.global(qos: .userInitiated).async{
            // creates Schools instance and appends to shared's collection
            
            Schools.shared.addSchool(school: School(name: name, coach: coach, teams: nil))
                // still on main thread, work is dismiss handler pushed serially after viewWillAppear and vieDidAppear
            }
        }
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
