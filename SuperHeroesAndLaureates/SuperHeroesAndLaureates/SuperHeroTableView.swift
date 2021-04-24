//
//  FirstViewController.swift
//  SuperHeroesAndLaureates
//
//  Created by Nick Pierce on 4/12/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class SuperHeroTableView: UITableViewController{
    
    // holds local reference for data source's data
    private var heroList: [SuperHero]?
    
    // defines activity indicator to apprise user of essential background task pending
    private let activityView: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assigns delegate and datasource to self
        tableView.dataSource = self
        tableView.delegate = self
        
        // at first load, configure properties and commence user interaction bar
        self.activityView.center = self.view.center
        self.activityView.style = UIActivityIndicatorView.Style.whiteLarge
        self.activityView.color = UIColor.green
        self.activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        
        // commences indicator run AND bars user interaction
        self.activityView.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // appends an observer to acquire the returned, loaded list of heroes
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHeroes(_ :)), name: Notification.Name.heroesLoaded, object: nil)
        
        // trying some dark magic here...
        
        // accessing nearest tabBarController and acquring the second tab/ view controller to append its observer
        (tabBarController!.viewControllers![1] as! LaureateTableView).appendObserver()
        
        // instigates the load for all superHeroes and laureates
        Retriever.shared.callingAllLaureates()
        Retriever.shared.callingAllHeros()
    }
    
    // updates local reference and invokes reload on main thread
    @objc private func reloadHeroes(_ notification: Notification) -> Void {  // may crash cuz it's private
        
        // assigns local refrence and invokes reload
        self.heroList = notification.userInfo!["ourHeroes..."] as? [SuperHero]
        
        DispatchQueue.main.sync {
            self.tableView.reloadData()
            self.activityView.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    // enumerates data-source methods for initial load
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroList?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let heroCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "hero")!
        
        // configures properties of table cell
        
        // acquires all powers for each hero
        var heroPower: String = ""
        for power: String in (self.heroList![indexPath.row]).powers {
            heroPower += power + ", "
        }

        // truncates extra unicode chars
        heroPower.removeSubrange(Range<String.Index>(uncheckedBounds: (lower: heroPower.index(heroPower.endIndex, offsetBy: -2), upper: heroPower.endIndex)))
        
        heroCell.textLabel!.text = "\(self.heroList![indexPath.row].name!) (aka: \(self.heroList![indexPath.row].secretIdentity!))"
        
        heroCell.detailTextLabel!.text = heroPower
       
        
        return heroCell
    }
    
    // renders header for section
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // holds header cell
        let headerCell = self.tableView.dequeueReusableCell(withIdentifier: "heroHeader")!
        
        // assigns the text value
        headerCell.textLabel!.text = "Heroes of the World!!"
        
        // styles the header cell
        headerCell.textLabel!.textColor = UIColor.white
        //headerCell.textLabel?.sizeToFit()
        
        headerCell.backgroundColor = UIColor.darkGray
        
        return headerCell
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 50)
    }


}

