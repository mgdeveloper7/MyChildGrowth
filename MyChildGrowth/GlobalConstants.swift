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
    
//    static var podDark = UIColor(red: 24/255, green: 25/255, blue: 26/255, alpha: 0.85)
//    static var podLight = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85)
//    
//    static var writingDark = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
//    static var writingLight = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//    
    static var dateViewShade = UIColor(red: 198/255, green: 233/255, blue: 245/255, alpha: 0.8)

    static var weightAndHeightSliderColour = UIColor(red: 255/255, green: 249/255, blue: 242/255, alpha: 1.0)
    static var datePickerColour = UIColor(red: 255/255, green: 249/255, blue: 242/255, alpha: 1.0)
    static var datePickerToolbarColour = UIColor(red: 237/255, green: 230/255, blue: 222/255, alpha: 1.0)
    
    
    // Screen shading
    struct ScreenShading {
        static var BackgroundImageAlpha = CGFloat(0.55)
        static var ViewBackgroundAlpha = CGFloat(0.90)
       // static var MainBackgroundImageName = "newborn-baby-feet-basket-pexels"
        static var MainBackgroundImageName = "baby-boy-hat-covered-101537"
      //  static var MainBackgroundImageName = "bear-pexels-photo-272056"
      //  static var MainBackgroundImageName = "child-crawling-pexels-photo-315265"
    }
    
    // Button
    struct ButtonShading {
        static var ButtonBackgroundColor = UIColor.gray
        static var ButtonBorderColor = UIColor.darkGray.cgColor
        static var ButtonCornerRadius = CGFloat(5.0)
    }
    
    // Tableview shading
    struct TableViewAlternateShading {
        static var Lighter = UIColor(red: 224/255, green: 218/255, blue: 210/255, alpha: 1.0)
        static var Darker = UIColor(red: 181/255, green: 173/255, blue: 166/255, alpha: 1.0)
       // static var Dummy = UIColor(red: 130/255, green: 127/255, blue: 120/255, alpha: 1.0)
        static var Dummy = UIColor(red: 91/255, green: 81/255, blue: 51/255, alpha: 0.9)
    }


}
