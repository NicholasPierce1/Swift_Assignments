//
//  Guesser.swift
//  Do You Feel Lucky, Punk? Well Do Ya?
//
//  Created by Nick Pierce on 2/27/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import Foundation
import UIKit

// class to hold the data models necessary to retain, and cull various statistics pertaining to user guess instances
class Guesser{
    
    // static instance that alludes to the only addressable object
    static var shared: Guesser = Guesser()
    
    // enumerates three private, stored properties
    private var correctAnswer: Int!
    private var _numAttempts: Int!
    private lazy var guesses: [Guess] = [Guess]()
    
    var numAttempts: Int {
        return _numAttempts
    }
    
    
    // struct to hold correctAnswers and attempts
    
    internal struct Guess{
        
        // list out the two props associated to a Guess
        var correctAnswer: Int
        var numAttemptsRequired: Int
    }
    
    // enum to hold the types of answers/ comparisons
    
    internal enum Result: String {
        case tooLow = "Too Low", tooHigh = "Too High", correct = "Correct!"
    }
    
    
    // method to render a random number and assigned it to correctAnswer + setting correctAnswer to 0
    func createNewProblem(){
        
        // gens random number
        correctAnswer = Int(arc4random_uniform(10)) + 1 // 1-10
        _numAttempts = 0
    }
    
    // increments _numAttempts and compares it to correctAnswer
    internal func amIRight(_ guess: Int) -> (Result?, UIAlertController?) {
        
        // checks if instance attributes AREN'T nil, a problem has been rendered
        if _numAttempts == nil {
            // creates new problem
            createNewProblem()
        }
        
        // increments _numAttempts
        _numAttempts += 1
        
        // compares to guess
        if guess == correctAnswer{ // if correct, add instance of guesses and render new problem
            // append a new instance to guesses
            guesses.append(Guess(correctAnswer: correctAnswer, numAttemptsRequired: _numAttempts))
            
            // temporary constant to hold _numAttempts
            let guessNum: Int = _numAttempts
            
            // render new problem
            self.createNewProblem()
            
            // return correct Enum
            return (Result.correct, displayCorrectMessage(guessNum: guessNum))
        }
        // if guess isn't correct
       // return (guess > correctAnswer ? (Result.tooHigh, nil) : (Result.tooLow, nil))
        else if guess > correctAnswer {
            return (Result.tooHigh, nil)
        }
        else{
            return (Result.tooLow, nil)
        }
        
    }
    
    // validates the input passed from GuesserViewController and returns the enum if valid
    internal func validateGuess(_ guess: String?) -> (Result?, UIAlertController?) {  // checks if can be converted to type Int
        
        guard let guess1 = Int(guess!) else{
            return (nil, displayIncorrectMessage())
        }
        

        return guess1 >= 1 && guess1 <= 10 ? amIRight(guess1) : (nil, displayIncorrectMessageRange())  // checks if range of int is suffice
       
        
    }
    
    // subscript to retun element of guesses array
    subscript(i: Int) -> Guess{
        return guesses[i]
    }
    
    // function to return the number of Guess objects in guesses
    func numGuesses() -> Int {
        return guesses.count
    }
    
    // function to clear the data in guesses
    func clearStatistics() {
        guesses = [Guess]()
    }
    
    // function to return the UIAlertController for the correct message
    func displayCorrectMessage(guessNum: Int) -> UIAlertController {
        let alertControl = UIAlertController(title: "Well done", message: "You got in \(guessNum)", preferredStyle: .alert)
        alertControl.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alertControl
    }
    
    func displayIncorrectMessage() -> UIAlertController {
        let alertControl = UIAlertController(title: "Uh oh...", message: "Invalid entry: please enter a num like \"8\" ", preferredStyle: .alert)
        alertControl.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alertControl
    }
    
    func displayIncorrectMessageRange() -> UIAlertController {
        let alertControl = UIAlertController(title: "Uh oh...", message: "Invalid entry: please enter a num within [0,10]", preferredStyle: .alert)
        alertControl.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alertControl
    }
    
    // function to return the minimun number of attempts
    func minimunNumAttempts() -> String {
        
        // test if guesses retains a value, return empty string
        if guesses.count == 0 {
            return String()
        }
        
        // creates local min
        var min: Int!
        
        // for loop to denote what minimun is
        for guess in guesses{
            
            if min == nil { // first element
                min = guess.numAttemptsRequired
            }
            else{  // not first element, check if lowest
                
                if guess.numAttemptsRequired < min {  // lower values, equals to
                    min = guess.numAttemptsRequired
                }
            }
        }
         return String(min)
    }
    
    // function to return the maximun number of attempts
    func maximunNumAttempts() -> String {
        
        // test if guesses retains a value, return empty string
        if guesses.count == 0 {
            return String()
        }
        
        // creates local min
        var min: Int!
        
        // for loop to denote what minimun is
        for guess in guesses{
            
            if min == nil { // first element
                min = guess.numAttemptsRequired
            }
            else{  // not first element, check if lowest
                
                if guess.numAttemptsRequired > min {  // lower values, equals to
                    min = guess.numAttemptsRequired
                }
            }
        }
        return String(min)
    }
    
    // function to return the mean
    func mean() -> String {
        
        // test if guesses retains a value, return empty string
        if guesses.count == 0 {
            return String()
        }
        
        // local var storing mean
        var mean: Int = 0
        
        for guess in guesses { // amss mean by number of guesses
            mean += guess.numAttemptsRequired
        }
        
        return String(Double(mean/guesses.count))
    }

    // function to return the standard deviation
    func standardDeviation() -> String {
        
        // test if guesses retains a value, return empty string
        if guesses.count == 0 {
            return String()
        }
        
        // acquires the mean
        let mean = Double(self.mean())!
        
        // holds aggregate of (mean - value)** 2
        var summation = 0.0
        
        // for loop to add to summation
        for guess in guesses{
            summation += pow((mean - Double(guess.numAttemptsRequired)), 2)
        }
        
        // return the summation divided by the amount of guesses- square root that
        return String(sqrt(summation / Double(guesses.count)))
    }
}
