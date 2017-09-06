//
//  DataCreationHelper.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 03/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class DataCreationHelper: NSObject {
    
    let lookupConfig = Realm.Configuration()
    
    // Lookup data creation
    
    func createVaccineTimePeriodsLookup() {
        
        do {
            // Get the default Realm
            let realm = try Realm()
            //let realm = try Realm(configuration: lookupConfig)
            
            try! realm.write {
                
//                dynamic var id = ""
//                dynamic var sequence = ""
//                dynamic var weekDueDescriptionKey = ""
//                dynamic var weekFrom = ""
//                dynamic var weekTo = ""
//                dynamic var dummyPeriod = false

                let timePeriodLookup1 = VaccineTimePeriodLookup()
                timePeriodLookup1.id = NSLocalizedString("8 weeks", comment: "")
                timePeriodLookup1.sequence = 1
                timePeriodLookup1.weekDueDescriptionKey = NSLocalizedString("8 weeks", comment: "")
                timePeriodLookup1.weekFrom = 8
                timePeriodLookup1.weekTo = 11
                timePeriodLookup1.dummyPeriod = false
                realm.add(timePeriodLookup1)
                
                let timePeriodLookup2 = VaccineTimePeriodLookup()
                timePeriodLookup2.id = NSLocalizedString("12 weeks", comment: "")
                timePeriodLookup2.sequence = 2
                timePeriodLookup2.weekDueDescriptionKey = NSLocalizedString("12 weeks", comment: "")
                timePeriodLookup2.weekFrom = 12
                timePeriodLookup2.weekTo = 15
                timePeriodLookup2.dummyPeriod = false
                realm.add(timePeriodLookup2)
                
                let timePeriodLookup3 = VaccineTimePeriodLookup()
                timePeriodLookup3.id = NSLocalizedString("16 weeks", comment: "")
                timePeriodLookup3.sequence = 3
                timePeriodLookup3.weekDueDescriptionKey = NSLocalizedString("16 weeks", comment: "")
                timePeriodLookup3.weekFrom = 16
                timePeriodLookup3.weekTo = 19
                timePeriodLookup3.dummyPeriod = false
                realm.add(timePeriodLookup3)
                
                let timePeriodLookup4 = VaccineTimePeriodLookup()
                timePeriodLookup4.id = "Dummy1"
                timePeriodLookup4.sequence = 4
                timePeriodLookup4.weekDueDescriptionKey = ""
                timePeriodLookup4.weekFrom = 20
                timePeriodLookup4.weekTo = 51
                timePeriodLookup4.dummyPeriod = true
                realm.add(timePeriodLookup4)
                
                let timePeriodLookup5 = VaccineTimePeriodLookup()
                timePeriodLookup5.id = NSLocalizedString("12 - 13 months", comment: "")
                timePeriodLookup5.sequence = 5
                timePeriodLookup5.weekDueDescriptionKey = NSLocalizedString("12 - 13 months", comment: "")
                timePeriodLookup5.weekFrom = 52
                timePeriodLookup5.weekTo = 58
                timePeriodLookup5.dummyPeriod = false
                realm.add(timePeriodLookup5)

                let timePeriodLookup6 = VaccineTimePeriodLookup()
                timePeriodLookup6.id = "Dummy2"
                timePeriodLookup6.sequence = 6
                timePeriodLookup6.weekDueDescriptionKey = ""
                timePeriodLookup6.weekFrom = 59
                timePeriodLookup6.weekTo = 179
                timePeriodLookup6.dummyPeriod = true
                realm.add(timePeriodLookup6)

                let timePeriodLookup7 = VaccineTimePeriodLookup()
                timePeriodLookup7.id = NSLocalizedString("3 years 4 months", comment: "")
                timePeriodLookup7.sequence = 7
                timePeriodLookup7.weekDueDescriptionKey = NSLocalizedString("3 years 4 months", comment: "")
                timePeriodLookup7.weekFrom = 180
                timePeriodLookup7.weekTo = 184
                timePeriodLookup7.dummyPeriod = false
                realm.add(timePeriodLookup7)

            }
            
        } catch let error as NSError {
            print("Error saving VaccineTimePeriodLookup to Realm - " + error.description)
        }

    }
    
    func createVaccineDescriptionsLookup() {
        
        do {
            // Get the default Realm
            let realm = try Realm()
            //let realm = try Realm(configuration: lookupConfig)
            
            try! realm.write {
                
//                dynamic var id = ""
//                dynamic var timePeriodLookupId = ""
//                dynamic var shortDescriptionKey = ""
//                dynamic var longDescriptionKey = ""

                // 8 Weeks
                
                let vaccineDescriptionLookup1 = VaccineDescriptionLookup()
                vaccineDescriptionLookup1.id = "8w-" + NSLocalizedString("DTaP/IPV/Hib", comment: "")
                vaccineDescriptionLookup1.sequence = 1
                vaccineDescriptionLookup1.timePeriodLookupId = NSLocalizedString("8 weeks", comment: "")
                vaccineDescriptionLookup1.shortDescriptionKey = NSLocalizedString("DTaP/IPV/Hib", comment: "")
                vaccineDescriptionLookup1.longDescriptionKey =
                    NSLocalizedString("DTaP-Key", comment: "") + ", " +
                    NSLocalizedString("IPV-Key", comment: "") + ", " +
                    NSLocalizedString("Hib-Key", comment: "")
                realm.add(vaccineDescriptionLookup1)
                
                let vaccineDescriptionLookup2 = VaccineDescriptionLookup()
                vaccineDescriptionLookup2.id = "8w-" + NSLocalizedString("PCV", comment: "")
                vaccineDescriptionLookup2.sequence = 2
                vaccineDescriptionLookup2.timePeriodLookupId = NSLocalizedString("8 weeks", comment: "")
                vaccineDescriptionLookup2.shortDescriptionKey = NSLocalizedString("PCV", comment: "")
                vaccineDescriptionLookup2.longDescriptionKey =
                    NSLocalizedString("PCV-Key", comment: "")
                realm.add(vaccineDescriptionLookup2)
                
                let vaccineDescriptionLookup3 = VaccineDescriptionLookup()
                vaccineDescriptionLookup3.id = "8w-" + NSLocalizedString("Rota", comment: "")
                vaccineDescriptionLookup3.sequence = 3
                vaccineDescriptionLookup3.timePeriodLookupId = NSLocalizedString("8 weeks", comment: "")
                vaccineDescriptionLookup3.shortDescriptionKey = NSLocalizedString("Rota", comment: "")
                vaccineDescriptionLookup3.longDescriptionKey =
                    NSLocalizedString("Rota-Key", comment: "")
                realm.add(vaccineDescriptionLookup3)
                
                // 12 Weeks
                
                let vaccineDescriptionLookup4 = VaccineDescriptionLookup()
                vaccineDescriptionLookup4.id = "12w-" + NSLocalizedString("DTaP/IPV/Hib", comment: "")
                vaccineDescriptionLookup4.sequence = 4
                vaccineDescriptionLookup4.timePeriodLookupId = NSLocalizedString("12 weeks", comment: "")
                vaccineDescriptionLookup4.shortDescriptionKey = NSLocalizedString("DTaP/IPV/Hib", comment: "")
                vaccineDescriptionLookup4.longDescriptionKey =
                    NSLocalizedString("DTaP-Key", comment: "") + ", " +
                    NSLocalizedString("IPV-Key", comment: "") + ", " +
                    NSLocalizedString("Hib-Key", comment: "")
                realm.add(vaccineDescriptionLookup4)

                let vaccineDescriptionLookup5 = VaccineDescriptionLookup()
                vaccineDescriptionLookup5.id = "12w-" + NSLocalizedString("MenC", comment: "")
                vaccineDescriptionLookup5.sequence = 5
                vaccineDescriptionLookup5.timePeriodLookupId = NSLocalizedString("12 weeks", comment: "")
                vaccineDescriptionLookup5.shortDescriptionKey = NSLocalizedString("MenC", comment: "")
                vaccineDescriptionLookup5.longDescriptionKey =
                    NSLocalizedString("MenC-Key", comment: "")
                realm.add(vaccineDescriptionLookup5)

                let vaccineDescriptionLookup6 = VaccineDescriptionLookup()
                vaccineDescriptionLookup6.id = "12w-" + NSLocalizedString("Rota", comment: "")
                vaccineDescriptionLookup6.sequence = 6
                vaccineDescriptionLookup6.timePeriodLookupId = NSLocalizedString("12 weeks", comment: "")
                vaccineDescriptionLookup6.shortDescriptionKey = NSLocalizedString("Rota", comment: "")
                vaccineDescriptionLookup6.longDescriptionKey =
                    NSLocalizedString("Rota-Key", comment: "")
                realm.add(vaccineDescriptionLookup6)
                
                // 16 weeks
                let vaccineDescriptionLookup7 = VaccineDescriptionLookup()
                vaccineDescriptionLookup7.id = "16w-" + NSLocalizedString("DTaP/IPV/Hib", comment: "")
                vaccineDescriptionLookup7.sequence = 7
                vaccineDescriptionLookup7.timePeriodLookupId = NSLocalizedString("16 weeks", comment: "")
                vaccineDescriptionLookup7.shortDescriptionKey = NSLocalizedString("DTaP/IPV/Hib", comment: "")
                vaccineDescriptionLookup7.longDescriptionKey =
                    NSLocalizedString("DTaP-Key", comment: "") + ", " +
                    NSLocalizedString("IPV-Key", comment: "") + ", " +
                    NSLocalizedString("Hib-Key", comment: "")
                realm.add(vaccineDescriptionLookup7)
                
                let vaccineDescriptionLookup8 = VaccineDescriptionLookup()
                vaccineDescriptionLookup8.id = "16w-" + NSLocalizedString("PCV", comment: "")
                vaccineDescriptionLookup8.sequence = 8
                vaccineDescriptionLookup8.timePeriodLookupId = NSLocalizedString("16 weeks", comment: "")
                vaccineDescriptionLookup8.shortDescriptionKey = NSLocalizedString("PCV", comment: "")
                vaccineDescriptionLookup8.longDescriptionKey =
                    NSLocalizedString("PCV-Key", comment: "")
                realm.add(vaccineDescriptionLookup8)
                
                // Between 12 and 13 months
                let vaccineDescriptionLookup9 = VaccineDescriptionLookup()
                vaccineDescriptionLookup9.id = "1213m-" + NSLocalizedString("Hib/MenC", comment: "")
                vaccineDescriptionLookup9.sequence = 9
                vaccineDescriptionLookup9.timePeriodLookupId = NSLocalizedString("12 - 13 months", comment: "")
                vaccineDescriptionLookup9.shortDescriptionKey = NSLocalizedString("Hib/MenC", comment: "")
                vaccineDescriptionLookup9.longDescriptionKey =
                    NSLocalizedString("Hib-Key", comment: "") + ", " +
                    NSLocalizedString("MenC-Key", comment: "")
                realm.add(vaccineDescriptionLookup9)
                
                let vaccineDescriptionLookup10 = VaccineDescriptionLookup()
                vaccineDescriptionLookup10.id = "1213m-" + NSLocalizedString("MMR", comment: "")
                vaccineDescriptionLookup10.sequence = 10
                vaccineDescriptionLookup10.timePeriodLookupId = NSLocalizedString("12 - 13 months", comment: "")
                vaccineDescriptionLookup10.shortDescriptionKey = NSLocalizedString("MMR", comment: "")
                vaccineDescriptionLookup10.longDescriptionKey =
                    NSLocalizedString("MMR-Key", comment: "")
                realm.add(vaccineDescriptionLookup10)
                
                let vaccineDescriptionLookup11 = VaccineDescriptionLookup()
                vaccineDescriptionLookup11.id = "1213m-" + NSLocalizedString("PCV", comment: "")
                vaccineDescriptionLookup11.sequence = 11
                vaccineDescriptionLookup11.timePeriodLookupId = NSLocalizedString("12 - 13 months", comment: "")
                vaccineDescriptionLookup11.shortDescriptionKey = NSLocalizedString("PCV", comment: "")
                vaccineDescriptionLookup11.longDescriptionKey =
                    NSLocalizedString("PCV-Key", comment: "")
                realm.add(vaccineDescriptionLookup11)
                
                // 3 years, 4 months
                let vaccineDescriptionLookup12 = VaccineDescriptionLookup()
                vaccineDescriptionLookup12.id = "3y4m-" + NSLocalizedString("DTaP/IPV", comment: "")
                vaccineDescriptionLookup12.sequence = 12
                vaccineDescriptionLookup12.timePeriodLookupId = NSLocalizedString("3 years 4 months", comment: "")
                vaccineDescriptionLookup12.shortDescriptionKey = NSLocalizedString("DTaP/IPV", comment: "")
                vaccineDescriptionLookup12.longDescriptionKey =
                    NSLocalizedString("DTaP-Key", comment: "") + ", " +
                    NSLocalizedString("IPV-Key", comment: "") + ", " +
                    NSLocalizedString("PRE-SCHOOL BOOSTER", comment: "") + ", " +
                    NSLocalizedString("Low-Dose-dTaP-Key", comment: "")
                realm.add(vaccineDescriptionLookup12)
 
                let vaccineDescriptionLookup13 = VaccineDescriptionLookup()
                vaccineDescriptionLookup13.id = "3y4m-" + NSLocalizedString("MMR", comment: "")
                vaccineDescriptionLookup13.sequence = 13
                vaccineDescriptionLookup13.timePeriodLookupId = NSLocalizedString("3 years 4 months", comment: "")
                vaccineDescriptionLookup13.shortDescriptionKey = NSLocalizedString("MMR", comment: "")
                vaccineDescriptionLookup13.longDescriptionKey =
                    NSLocalizedString("MMR-Key", comment: "")
                realm.add(vaccineDescriptionLookup13)
                
            }
            
        } catch let error as NSError {
            print("Error saving VaccineDescriptionLookup to Realm - " + error.description)
        }

    }
    
    // Demo Data creation
    
    func createChildProfileDemoTable() {
        
    }

    func createHeightDemoTable() {
        
    }
    
    func createWeightDemoTable() {
        
    }


}
