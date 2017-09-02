//
//  Weight.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 31/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class Weight: NSObject {

    dynamic var id = ""
    dynamic var childProfileId = ""
    dynamic var dateWeighed : NSDate? = nil
    dynamic var value = 0.0
}
