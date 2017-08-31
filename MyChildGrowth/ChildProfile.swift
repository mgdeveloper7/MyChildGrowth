//
//  ChildProfile.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 24/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class ChildProfile: Object {
    dynamic var id = ""
    dynamic var firstname = ""
    dynamic var surname = ""
    dynamic var sex = ""
    dynamic var dateOfBirth : NSDate? = nil
    dynamic var weightAtBirth = 0.0

}
