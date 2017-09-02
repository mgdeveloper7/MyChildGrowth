//
//  Height.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 31/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class Height: Object {
    
    dynamic var id = ""
    dynamic var childProfileId = ""
    dynamic var dateMeasured : NSDate? = nil
    dynamic var value = 0.0
}
