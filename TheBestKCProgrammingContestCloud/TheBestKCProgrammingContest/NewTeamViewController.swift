//
//  AddTeamViewController.swift
//  TheBestKCProgrammingContest
//
//  Created by Nick Pierce on 3/12/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class NewTeamViewController: UIViewController {
    
    // property to refer to the selected School and parent VC
    var selectedSchool: School!
    var presented: TeamsTableViewController!
    
    // enumerates outlets
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var student0: UITextField!
    @IBOutlet weak var student1: UITextField!
    @IBOutlet weak var student2: UITextField!
    
    // array containing students
    var studentArray: [UITextField?] = [] // initialized value, will be overriden in viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        studentArray = [student0,student1,student2]
        // Do any additional setup after loading the view.
    }
    
    // dismisses all UITextField data and returns to modally presented
    @IBAction func cancel(_ sender: Any){
        
        // invokes dismiss and clears UITextFields
        self.dismiss(animated: true) {
            for textField in self.studentArray{
                textField?.text = ""
            }
        }
    }
    
    // appends new team to school and dismisses to Presented modally
    @IBAction func done(_ sender: Any?){
        // informs user of background process and bars subsuquent user interaction
        self.presented.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // creates local references to be used in background thread
        let name = self.name.text!
        let students: [String] = studentArray.map({return $0!.text! != "" ? $0!.text! : "student not entered"})
        
        // invokes dismiss and appends new team instance to that school
        self.dismiss(animated: true){

            
            DispatchQueue.global(qos: .userInteractive).async{
                Schools.shared.addTeam(forSchool: self.selectedSchool, withTeam: Team(name: name, students: students))
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
