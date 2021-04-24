//
//  FirstViewController.swift
//  Do You Feel Lucky, Punk? Well Do Ya?
//
//  Created by Nick Pierce on 2/26/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import UIKit

class GuesserViewController: UIViewController {

    // enumerates outlets for tab
    
    @IBOutlet weak var guessVar: UITextField! // to hold the user guess
    
    @IBOutlet weak var displayLabel: UILabel! // to display the apt message corresponding to user guess
    
    
    // function to compare guessVar to guessValue and append data to model as needed
    @IBAction func guess(_ sender: Any?){
        // invokes validation method and acquires return type
        let tupleReturn = Guesser.shared.validateGuess(guessVar.text)
        
        // checks if Result? is nil, handle accordingly
        if tupleReturn.0 == nil { // nil case
            self.show(tupleReturn.1!, sender: nil)
        }
        // check tupleReturn's value for the enumType
        else if tupleReturn.0!.rawValue == "Correct!"{
            // show correct message
            self.show(tupleReturn.1!, sender: nil)
            displayLabel.text = tupleReturn.0!.rawValue
        }
        else if tupleReturn.0!.rawValue == "Too Low" { // label shows too low
            displayLabel.text = tupleReturn.0!.rawValue
        }
        else{ // label shows too high
            displayLabel.text = tupleReturn.0!.rawValue
        }
    }
    
    // function to clear textField, guesslabel, and establishes a new guessValue
    @IBAction func createNew(_ sender: Any?){ // creates newProblem without appending instance to guesses
        Guesser.shared.createNewProblem()
        
        // clears labels
        displayLabel.text = ""
        guessVar.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the label's value to empty string
        displayLabel.text = ""
        
    }


}

