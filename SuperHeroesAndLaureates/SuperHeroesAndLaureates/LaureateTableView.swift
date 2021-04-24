//
//  SecondViewController.swift
//  SuperHeroesAndLaureates
//
//  Created by Nick Pierce on 4/12/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class LaureateTableView: UITableViewController {
    
    // holds local reference containing all laureates
    private var laureateList: [[String: Any]]?
    
    // defines an activity indicator to alert user of essential, pending background task
    private let activityView: UIActivityIndicatorView = UIActivityIndicatorView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // denotes the datasource and delegate to self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // configures and starts animating activity indicator
        self.activityView.center = self.view.center
        self.activityView.style = UIActivityIndicatorView.Style.whiteLarge
        self.activityView.color = UIColor.green
        self.activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        
        // starts animating and bars user interaction events
        self.activityView.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        // appends an observer to be invoked when laureates are loaded
        //NotificationCenter.default.addObserver(self, selector: #selector(reloadLaureates(_ :)), name: Notification.Name.lauSomethingLoaded, object: nil)
    }
    
    // appends an observer to self
    internal func appendObserver() -> Void{
        NotificationCenter.default.addObserver(self, selector: #selector(reloadLaureates(_:)), name: Notification.Name.lauSomethingLoaded, object: nil)
    }
    
    // updates local reference and enjoins reload
    @objc private func reloadLaureates(_ notification: Notification) -> Void{
        
        // updates local reference and invokes reload of table
        self.laureateList = notification.userInfo!["ourHonorablePeople..."] as? [[String:Any]]
        
        // pushes main thread to update and cease activityIndicatorView
        DispatchQueue.main.sync{
            
            //  verifies that view is loaded, redraws view no view tailored to controller
            if self.view == nil { // no view loaded, load view
                self.view.setNeedsDisplay()
                self.activityView.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                return
            }
            
            self.tableView.reloadData()
            self.activityView.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    // enumerates data source methods for rendering table view
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laureateList?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let laureateCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "laureate")!
        
        // configures properties of cell
        (laureateCell.viewWithTag(69) as! UILabel).text = "\(laureateList![indexPath.row]["firstname"]!) \(laureateList![indexPath.row]["surname"]!)"
        
        (laureateCell.viewWithTag(420) as! UILabel).text = "Born: \(laureateList![indexPath.row]["born"]!) Death: \(laureateList![indexPath.row]["died"]!)"
        
        return laureateCell
    }
    
    // renders custom header view
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // assigns header cell
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "laureateHeader")!
        
        // configures properties
        headerCell.textLabel!.text = "Laureates of our time"
        headerCell.textLabel?.textColor = UIColor.white
        headerCell.backgroundColor = UIColor.darkGray
        
        return headerCell
    }
    
    // amends height of cell
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 50)
    }


}
