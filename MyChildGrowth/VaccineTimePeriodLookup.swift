//
//  VaccineTimePeriodLookup.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 03/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class VaccineTimePeriodLookup: Object {

    dynamic var id = ""
    dynamic var sequence = 0
    dynamic var weekDueDescriptionKey = ""
    dynamic var weekFrom = 0
    dynamic var weekTo = 0
    dynamic var dummyPeriod = false

}
