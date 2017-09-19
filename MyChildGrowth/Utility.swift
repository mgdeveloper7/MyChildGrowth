//
//  Utility.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 19/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func getDocumentsDirectoryURL() -> URL {

        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    class func getBuildVersion() -> String {
        
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        
    }
    
    class func getChildIcon(sex : NSString) -> String {
        
        var imageName = ""
        
        if sex == "Male" {
            imageName = GlobalConstants.ChildIcon.Boy
        }
        else {
            imageName = GlobalConstants.ChildIcon.Girl
        }

        return imageName
    }

    class func showMessage(titleString : String, messageString : String)
    {
        let alertView = UIAlertView(title: titleString, message: messageString, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
        
        
        //        let alertController = UIAlertController(title: titleString, message:  messageString, preferredStyle: UIAlertControllerStyle.alert)
        //
        //        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        //            print("OK")
        //        }
        //
        //        alertController.addAction(okAction)
        //        self.present(alertController, animated: true, completion: nil)
        
    }

}
