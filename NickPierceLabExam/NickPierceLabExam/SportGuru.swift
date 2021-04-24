//
//  SportGuru.swift
//  NickPierceLabExam
//
//  Created by Pierce,Nicholas A on 4/16/19.
//  Copyright © 2019 Pierce,Nicholas A. All rights reserved.
//

import Foundation


// calculates the corresponding VO2 max in regards to passed input and returns the level/ quality of calculated VO2

internal struct SportsGuru{
    
    // singleton instance to be invoked by VCs
    internal static let shared: SportsGuru = SportsGuru()
    
    // calculates and returns VO2 per indivual characteristics
    internal func vO2Max(weight: Double, age: Int, sex: Int, time: Double, heartRate: Double) -> Double{
        return 132.853 - (0.0769 * weight) - (0.3877 * Double(age)) + (6.3150 * Double(sex)) - (3.2649 * time) - (0.1565 * heartRate)
    }
    
    // returns the corresponding label per V02 max of individual
    internal func vO2MaxClassification(_ vO2Max: Double) -> String {
        
        // evaluates vO2 max per range specifications
        switch vO2Max{
        case 0..<47.0:
            return "Average"
        case 47.0..<52.0:
            return "Above average"
        case 52.0..<60.0:
            return "Good"
        default:  // [60 - infinity)
            return "Excellent"
        }
    }
}
