//
//  GlobalConstants.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 23/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class GlobalConstants: NSObject {

    // Create a singleton so that the variables can be called outside of the class
    static let sharedInstance = GlobalConstants()

    static let AppName = "MyChildGrowth"
    
    struct ColourScheme {
        static var Dark = "Dark"
        static var Light = "Light"
    }
    
    static var podDark = UIColor(red: 24/255, green: 25/255, blue: 26/255, alpha: 0.85)
    static var podLight = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85)
    
    static var writingDark = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    static var writingLight = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    
    static var dateViewShade = UIColor(red: 198/255, green: 233/255, blue: 245/255, alpha: 0.8)

    static var weightAndHeightSliderColour = UIColor(red: 255/255, green: 249/255, blue: 242/255, alpha: 1.0)
    static var datePickerColour = UIColor(red: 255/255, green: 249/255, blue: 242/255, alpha: 1.0)
    static var datePickerToolbarColour = UIColor(red: 237/255, green: 230/255, blue: 222/255, alpha: 1.0)
    

}
