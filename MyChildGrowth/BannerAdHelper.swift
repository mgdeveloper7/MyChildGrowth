//
//  BannerAdHelper.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 20/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BannerAdHelper: NSObject {

    class func getGADRequest() -> GADRequest {
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        
        let request = GADRequest()
        if AppSettings.BannerAdsTestMode {
            // Display test banner ads in the simulator
            request.testDevices = [GlobalConstants.BannerAdTestIDs.Simulator,
                                   GlobalConstants.BannerAdTestIDs.IPhone6]
        }
        
        return request

    }
}
