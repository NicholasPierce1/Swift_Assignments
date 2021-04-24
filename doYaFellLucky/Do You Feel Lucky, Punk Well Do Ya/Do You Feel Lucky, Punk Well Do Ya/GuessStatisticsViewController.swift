//
//  GuessStatistics.swift
//  Do You Feel Lucky, Punk? Well Do Ya?
//
//  Created by Nick Pierce on 2/26/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class GuessStatisticsViewController: UIViewController {
    
    // enumerates UIViewOutlets
    
    @IBOutlet weak var minLabel: UITextField!
    
    @IBOutlet weak var maxLabel: UITextField!
    
    @IBOutlet weak var meanLabel: UITextField!
    
    @IBOutlet weak var stdDevLabel: UITextField!
    
    // defines an IB Function to clear statistics and model
    @IBAction func clear(_ sender: Any){
        // clears data stored in model
        Guesser.shared.clearStatistics()
        
        // clears outlets
        clearStats()
    }
    
    // loads view and assigns apt values to outlets
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        minLabel.text = Guesser.shared.minimunNumAttempts()
        maxLabel.text = Guesser.shared.maximunNumAttempts()
        meanLabel.text = Guesser.shared.mean()
        stdDevLabel.text = Guesser.shared.standardDeviation()
    }
    
    // function to enjoin compiler to return a refreshed view
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    // function to clear statistics
    func clearStats(){
        minLabel.text = ""
        maxLabel.text = ""
        meanLabel.text = ""
        stdDevLabel.text = ""
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
