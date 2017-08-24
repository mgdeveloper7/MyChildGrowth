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


}
