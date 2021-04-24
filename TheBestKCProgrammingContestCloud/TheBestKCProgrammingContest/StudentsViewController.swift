//
//  StudentsViewController.swift
//  TheBestKCProgrammingContest
//
//  Created by Nick Pierce on 3/12/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController {
    
    // holds selected team from previous Navigation ViewController
    var selectedTeam: Team!
    
    // enumerates outlets
    @IBOutlet weak var student0: UILabel!
    
    @IBOutlet weak var student1: UILabel!
    
    @IBOutlet weak var student2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // enjoins view to be reloaded
    override func viewWillAppear(_ animated: Bool) {
        // assigns the names to each of the students
        /*
        let studentArray: [UILabel?] = [student0, student1, student2]
        
        for i in 0 ..< selectedTeam.students.count {
            studentArray[i]?.text = "text"//[selectedTeam.student1!, selectedTeam.student2!, selectedTeam.student3!][i] // assigns name of student to label

        }*/
        
        student0.text = selectedTeam.student1!
        student1.text = selectedTeam.student2!
        student2.text = selectedTeam.student3!
 
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
