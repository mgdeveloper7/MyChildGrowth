//
//  ChildVaccineTaken.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 03/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class ChildVaccineTaken: Object {

    dynamic var id = ""
    dynamic var childProfileId = ""
    dynamic var vaccineTimePeriodId = ""
    dynamic var vaccineDescriptionId = ""
    dynamic var notes = ""

}
