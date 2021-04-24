//
//  SecondViewController.swift
//  Do You Feel Lucky, Punk? Well Do Ya?
//
//  Created by Nick Pierce on 2/26/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class GuessHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // enumerated IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // defining needed methods to populate tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Guesser.shared.guesses holds only one array
    }
    
    // returns number of rows in guesses
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Guesser.shared.numGuesses()
    }
    
    // returns cell with the corresponding text and detailText assigned
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // acquire cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "history")!
        
        // populate cell's view
        cell.detailTextLabel!.text = String("# of Attempts \(Guesser.shared[indexPath.row].numAttemptsRequired)")
        cell.textLabel!.text = String("Correct Answer: \(Guesser.shared[indexPath.row].correctAnswer)")
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    // method for refreshing
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
        tableView.reloadData()
    }

}

