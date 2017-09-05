//
//  InnoculationsVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 03/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class InnoculationsVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var outerChildDetailView : UIView!
    @IBOutlet weak var genderImage : UIImageView!
    @IBOutlet weak var firstname : UILabel!
    @IBOutlet weak var surname : UILabel!

    @IBOutlet weak var timelineTableView : UITableView!
    @IBOutlet weak var innoculationsOuterView : UIView!
    @IBOutlet weak var innoculationsTableView : UITableView!

    @IBOutlet weak var innoculationDescriptionView : UIView!
    @IBOutlet weak var innoculationDescriptionPeriod : UILabel!
    @IBOutlet weak var innoculationDescription : UILabel!

    var selectedChildProfile = ChildProfile()

    var selectedTimePeriod = VaccineTimePeriodLookup()
    var selectedInnoculationForTimePeriod = VaccineDescriptionLookup()
    
    var innoculationPeriods : Results<VaccineTimePeriodLookup>!
    var innoculationsForTimePeriod : Results<VaccineDescriptionLookup>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getInnoculationPeriods()
        getInnoculationForTimePeriods()
        
        setupScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupScreen() {
        
        // Child details and image
        self.firstname.text = selectedChildProfile.firstname
        self.surname.text = selectedChildProfile.surname

        // Child details and image
        self.firstname.text = selectedChildProfile.firstname
        self.surname.text = selectedChildProfile.surname
        
        var imageName = ""
        
        if selectedChildProfile.sex == "Male" {
            imageName = "boy-icon"
        }
        else {
            imageName = "girl-icon"
        }
        
        let image = UIImage(named: imageName)
        genderImage.image = image

        // Views
        timelineTableView.layer.cornerRadius = 10.0
        timelineTableView.layer.borderWidth = 1
        timelineTableView.layer.borderColor = UIColor.gray.cgColor
        timelineTableView.alpha = 0.6
        
        innoculationsOuterView.layer.cornerRadius = 10.0
        innoculationsOuterView.layer.borderWidth = 1
        innoculationsOuterView.layer.borderColor = UIColor.gray.cgColor
        innoculationsOuterView.alpha = 0.6
        
        innoculationDescriptionView.layer.cornerRadius = 10.0
        innoculationDescriptionView.layer.borderWidth = 1
        innoculationDescriptionView.layer.borderColor = UIColor.gray.cgColor
        innoculationDescriptionView.alpha = 0.6
        
    }

    func getInnoculationPeriods() {
        
        innoculationPeriods = try! Realm().objects(VaccineTimePeriodLookup.self)
        innoculationPeriods = innoculationPeriods!.sorted(byKeyPath: "sequence", ascending: true)
    }
    
    func getInnoculationForTimePeriods() {
        
        let predicate = NSPredicate(format: "timePeriodLookupId == %@", selectedTimePeriod.id)

        innoculationsForTimePeriod = try! Realm().objects(VaccineDescriptionLookup.self).filter(predicate)
        innoculationsForTimePeriod = innoculationsForTimePeriod!.sorted(byKeyPath: "sequence", ascending: true)
    }

    func populateInnoculationDescriptionForTimePeriod() {
        
        innoculationDescriptionPeriod.text = selectedInnoculationForTimePeriod.timePeriodLookupId
        innoculationDescription.text = selectedInnoculationForTimePeriod.longDescriptionKey
    }

    func clearInnoculationDescriptionForTimePeriod() {
        
        innoculationDescriptionPeriod.text = ""
        innoculationDescription.text = ""
    }

    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK:  Extensions

extension InnoculationsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        if tableView == self.timelineTableView {
            count = innoculationPeriods.count
        }
        
        if tableView == self.innoculationsTableView {
            
            count = innoculationsForTimePeriod.count
        }
        
        return count
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight = 0.0
        
        if tableView == self.timelineTableView {

            let period = innoculationPeriods[indexPath.row]
            
            if period.dummyPeriod == true {
                cellHeight = 20
            }
            else {
                cellHeight = Double(tableView.rowHeight-2)
            }
            
        }
        
        if tableView == self.innoculationsTableView {
            cellHeight = Double(tableView.rowHeight-2)
        }
        
        return CGFloat(cellHeight)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var mainCell = UITableViewCell()
        
        if tableView == self.timelineTableView {
            
            let period = innoculationPeriods[indexPath.row]

            let cell:InnoculationsTimePeriodCell = self.timelineTableView.dequeueReusableCell(withIdentifier: "InnoculationsTimePeriodCellID") as! InnoculationsTimePeriodCell
            
            cell.timePeriod.text = period.weekDueDescriptionKey
            
            // Colour shading
            
            if period.dummyPeriod == true {
                cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Dummy
                cell.selectedLabel.backgroundColor = GlobalConstants.TableViewAlternateShading.Dummy
                cell.isUserInteractionEnabled = false // selectionStyle = .none
 //               cell.backgroundColor = UIColor.gray
            }
            else {
                if (indexPath.row % 2 == 0) {
                    cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker
                    cell.selectedLabel.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker
                }
                else {
                    cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
                    cell.selectedLabel.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
                }
            }
            
            mainCell = cell
        }
        
        if tableView == self.innoculationsTableView {
            
            let desc = innoculationsForTimePeriod[indexPath.row]

            let cell:InnoculationDescriptionCell = self.innoculationsTableView.dequeueReusableCell(withIdentifier: "InnoculationDescriptionCellID") as! InnoculationDescriptionCell
            
            cell.shortDescription.text = desc.shortDescriptionKey
            
            // Colour shading
            
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker
                cell.selectedLabel.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker
            }
            else {
                cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
                cell.selectedLabel.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
            }

            
            mainCell = cell
        }

        return mainCell
    }
    
}

// MARK: UITableViewDelegate
extension InnoculationsVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == self.timelineTableView {
            selectedTimePeriod = innoculationPeriods[indexPath.row]
            
            // Reload the innoculation descriptions, based on selected time period
            getInnoculationForTimePeriods()
            innoculationsTableView.reloadData()
            clearInnoculationDescriptionForTimePeriod()

            if let cell = (tableView.cellForRow(at: indexPath) as? InnoculationsTimePeriodCell) {
                
                // Highlight the cell as selected
                cell.contentView.backgroundColor = UIColor.gray
                cell.selectedLabel.backgroundColor = UIColor.red
                
            }
        }
        
        if tableView == self.innoculationsTableView {
            
            selectedInnoculationForTimePeriod = innoculationsForTimePeriod[indexPath.row]
            populateInnoculationDescriptionForTimePeriod()
            
            if let cell = (tableView.cellForRow(at: indexPath) as? InnoculationDescriptionCell) {
                
                cell.contentView.backgroundColor = UIColor.gray
                cell.selectedLabel.backgroundColor = UIColor.red
            }
        }

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        selectedHeightToDelete = heights[indexPath.row]
//        
//        if editingStyle == .delete
//        {
//            askToRemoveHeight()
//        }
//    }
    
}



