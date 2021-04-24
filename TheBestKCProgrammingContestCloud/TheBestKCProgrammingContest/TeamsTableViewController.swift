//
//  TeamsTableViewController.swift
//  TheBestKCProgrammingContest
//
//  Created by Nick Pierce on 3/12/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class TeamsTableViewController: UITableViewController {
    
    // holds the selected school and teams from prior Navigation ViewController
    var choosenSchool: School!
    var teamsForSchool: [Team]?
    
    // holds parent VC to update local reference
    var schoolTVC: SchoolsTableViewController!
    
    // renders activityIndicator to pause integral processes occurring in the background
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // navigation item for nav bar
    @IBOutlet weak var teamNavItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // denotes properties and appends to view
        activityIndicator.center = self.view.center
        activityIndicator.center.y = activityIndicator.center.y - CGFloat(0.25)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = UIColor.green
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        
        // appends an observer
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTeams(_ :)), name: Notification.Name.reloadTeams, object: nil)
        
        // sets title of navigation item
        self.navigationItem.title = choosenSchool.name
        
        // could be done also by...
        //self.teamNavItem.title = choosenSchool.name
    }
    
    // reloads teams and permits user interaction
    @objc func reloadTeams(_ notification: Notification){
        DispatchQueue.main.sync{
            // extract and update local team reference
            self.teamsForSchool = (notification.userInfo as! [String: [Team]])["teams"]!
            
            // updates table
            self.tableView.reloadData()
            
            // resumes user interaction
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            // updates parent local reference
            self.schoolTVC.schools![self.schoolTVC.schools!.firstIndex(of: self.choosenSchool)!].teams = self.teamsForSchool!
        }}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        // #warning Incomplete implementation, return the number of rows
        return teamsForSchool?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teams")!
        
        let label: UILabel = cell.viewWithTag(100) as! UILabel
        label.text = self.teamsForSchool?[indexPath.row].name

        return cell
    }
    
    // handles configuration for presenting ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // checks identifier for if presenting ViewController is StudentsViewContoller
        if segue.identifier == "teamsStudents" {
            
            // assigns the specify team to StudentVC's property
            (segue.destination as! StudentsViewController).selectedTeam = self.teamsForSchool?[ tableView.indexPathForSelectedRow!.row ]
            
            // invokes the need to redraw pending view's rectangle/ UIWindow.bounds
            (segue.destination as! StudentsViewController).view.setNeedsDisplay()
            return
        }
        
        // else NewTeamViewController
        
        // assigns property value to specify current school
        (segue.destination as! NewTeamViewController).selectedSchool = self.choosenSchool
        (segue.destination as! NewTeamViewController).presented = self
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
