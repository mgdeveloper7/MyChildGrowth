//
//  GlobalConstants.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 23/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GlobalConstants: NSObject {

    // Create a singleton so that the variables can be called outside of the class
    static let sharedInstance = GlobalConstants()

    static let AppName = "MyChildGrowth"
    
    struct ColourScheme {
        static var Dark = "Dark"
        static var Light = "Light"
    }
    
    struct Realm {
        static var DefaultRealm = "default.realm"
    }
    
    // Child Icons
    
    struct ChildIcon {
        static var Boy = "boy-icon"
        static var Girl = "girl-icon"
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
        static var BackgroundImageAlpha = CGFloat(0.60)
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

    // URL's
    // Ensure no spaces in URL
    
    static let SupportEmailAddress = "mgdeveloper7@gmail.com"
    //static let DarkSkyURL = "https://darksky.net/poweredby/"
    static let WeatherIconURL = "https://icons8.com"
    static let WeatherPhotosURL = "https://www.pexels.com"

    // MARK:  Banner Ad related
    
    // Get Started:  https://firebase.google.com/docs/admob/ios/quick-start
    
    struct BannerAdTestIDs {
        // List of devices used whilst testing, in order to see test banner ads
        static let IPhone6 = "d908ab2aa2246c48dd031abe26ac03f5"
        static let Simulator = kGADSimulatorID
    }
    
    static let AdMobAppID = "ca-app-pub-7564315004238579~6456081731"
    static let AdMobBannerID = "ca-app-pub-7564315004238579/4667469297"
//    
//    static let TestAdMobAppID = "ca-app-pub-3940256099942544~1458002511"
//    static let TestAdMobBannerID = "ca-app-pub-3940256099942544/2934735716"
    
    //  How often banner ads are shown on some screens (e.g 3 means display ads once every 3 times)
    static let BannerAdDisplayFrequency = 1


}
