//
//  RealmHelper.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 03/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class RealmHelper: NSObject {

    func getLookupRealm() {
        
        //    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        //    NSString *customRealmPath = [documentsDirectory stringByAppendingPathComponent:@"MyBundledData.realm"];
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       // let customRealmPath = documentsUrl + "/LookupData.realm"

    }
}
