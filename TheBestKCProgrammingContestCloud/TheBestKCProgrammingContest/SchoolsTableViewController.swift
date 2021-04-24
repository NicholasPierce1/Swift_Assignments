//
//  SchoolsTableViewController.swift
//  TheBestKCProgrammingContest
//
//  Created by Nick Pierce on 3/12/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class SchoolsTableViewController: UITableViewController {
    
    // denotes an activityIndicator
    var activityIndicator: UIActivityIndicatorView!
    
    // local reference to current school array
    var schools: [School]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // creates an observer to reload
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSchools(_ :)), name: Notification.Name.reloadSchools, object: nil)
        
        // renders an activityIndicator for buffering user action between essential background processes
        activityIndicator = UIActivityIndicatorView()
        
        // sets location of activityIndicator
        activityIndicator.center = self.view.center
        
        // establishes the style of activityIndicator
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        
        // sets color (why not)
        activityIndicator.color = UIColor.green
        
        // enjoins indicatorView to hide when not animating
        activityIndicator.hidesWhenStopped = true
        
        // appends to view's sublayer
        self.view.addSubview(activityIndicator)
        
        // intial load- bar userinteration to load is complete
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // local variable to instigate thread
        let _ = Schools.shared
        
    }
    
    // reloads school, invoked by notification
    @objc func reloadSchools(_ notification: Notification) -> Void{
        
        // pushes work onto main thread
        DispatchQueue.main.sync{
            
            // checks if userInfo contains data
            if let schools = (notification.userInfo as! [String: [School]])["schools"]{
                // object info passed, update local reference
                self.schools = schools
            }
            
            // reloads data and resumes user interaction
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            print(schools!.count)
        }
    }
    
    // configures the swipe action (trailing) to delete
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // assigns a UIContextual Action by invoking a subsequent method
        let deleteAction: UIContextualAction = delete(at: indexPath)
        
        // returns the action to the configuration
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // creates and returns delete contextual action
    func delete(at indexPath: IndexPath) -> UIContextualAction {
        
        return UIContextualAction(style: .destructive, title: "Delete"){
            (action, view, completion) -> () in
            
            // holds local references for global queue
            let schools = self.schools!
            
            // dispatches background thread to update model
            DispatchQueue.global(qos: .userInteractive).async{
                print(String(format: "indexpath row: %d -- number of schools: %d", indexPath.row, schools.count))
                Schools.shared.delete(school: schools[indexPath.row])
            }
            
            // deletes School from local reference THEN the table
            self.schools?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            // enjoins tableView to reload data
            self.tableView.reloadData()
            
            // declares handler is complete
            completion(true)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schools?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schools")!

        // assigns textLabel and detailTextLabel
        cell.textLabel?.text = schools?[indexPath.row].name // name of school
        cell.detailTextLabel?.text = schools?[indexPath.row].coach // coach for school

        return cell
    }
    
    // checks, and if so, configures TeamsTableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        // checks if triggered segue leads to TeamsTVC
        guard let teamViewController = segue.destination as? TeamsTableViewController else{
            
            // addSchool
            (segue.destination as! NewSchoolViewController).presented = self
            return
        }
        
        teamViewController.choosenSchool = schools?[tableView.indexPathForSelectedRow!.row]
        teamViewController.teamsForSchool = schools?[tableView.indexPathForSelectedRow!.row].teams
        teamViewController.schoolTVC = self
        
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
