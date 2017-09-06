//
//  Conversions.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 30/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class Conversions: NSObject {

    // Create a singleton so that the variables can be called outside of the class
//    static let sharedInstance = Conversions()

    func kgToStones(kgWeight : Float) -> String {
        
        let conversionFormula = 0.157473
        
        return String(Double(kgWeight) * conversionFormula)
        
    }
    
    func kgToPounds(kgWeight : Float) -> String {
        
        let conversionFormula = 2.20462
        
   //     return String(Int (Double(kgWeight) * conversionFormula) )
        return String(Double(kgWeight) * conversionFormula)
        
    }
    
    func metersToFeet(meters : Float) -> String {
        
        let conversionFormula = 3.28084
        
        return String(Double(meters) * conversionFormula)
        
    }
    
    func feetFractionToInches(feetFraction : Double) -> String {
        
        let conversionFormula = Double(12)
        
        return String(floor(feetFraction * conversionFormula))
        
    }



//    func stoneFractionToPounds(poundsFraction : Double) -> String {
//        
//        let conversionFormula = 14
//        
//        return String(Int (poundsFraction * Double(conversionFormula)) )
//        
//    }

}
