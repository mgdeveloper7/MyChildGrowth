//
//  HeightReviewListVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 31/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class HeightReviewListVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var titleBarNavItem: UINavigationItem!
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var outerChildDetailView : ChildNameView!
    @IBOutlet weak var enterHeightView : UIView!
    
    @IBOutlet weak var heightsTableView : UITableView!
    
    var selectedChildProfile = ChildProfile()
    var selectedHeightToDelete = Height()
    
    var heights : Results<Height>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        getHeightsForChild()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupScreen() {

        titleBarNavItem.setTitle(title: "MyChildGrowth", subtitle: "List Child Heights")

        outerScreenImageView.image = UIImage(named: GlobalConstants.ScreenShading.MainBackgroundImageName)
        outerScreenImageView.alpha = GlobalConstants.ScreenShading.BackgroundImageAlpha

        outerChildDetailView.layer.cornerRadius = 10.0
        outerChildDetailView.layer.borderWidth = 1
        outerChildDetailView.layer.borderColor = UIColor.gray.cgColor
        outerChildDetailView.clipsToBounds = true
        outerChildDetailView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        outerChildDetailView.alpha = GlobalConstants.ScreenShading.ViewBackgroundAlpha

        enterHeightView.layer.cornerRadius = 10.0
        enterHeightView.layer.borderWidth = 1
        enterHeightView.layer.borderColor = UIColor.gray.cgColor
        enterHeightView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        enterHeightView.alpha = GlobalConstants.ScreenShading.ViewBackgroundAlpha

        // Tableview
        heightsTableView.allowsSelection = false
        heightsTableView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        
        // Child details and image
        outerChildDetailView.buildView(firstNameString: selectedChildProfile.firstname, lastNameString: selectedChildProfile.surname, sexString: selectedChildProfile.sex)
        

    }
    
    func getHeightsForChild() {
        
        // TODO: Add to HeightHelper class
        
        let predicate = NSPredicate(format: "childProfileId == %@", selectedChildProfile.id)
        heights = try! Realm().objects(Height.self).filter(predicate)
        heights = heights!.sorted(byKeyPath: "dateMeasured", ascending: false)

    }
    
    func askToRemoveHeight() {
        
        let alert = UIAlertController(title: "Remove Height", message: "Are you sure you want to remove this height?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Ok", style: .destructive) { (alert: UIAlertAction!) -> Void in
            
            self.removeHeightFromRealm()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
            //print("You pressed Cancel")
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)
    }
    
    func removeHeightFromRealm() {
        
        do {
            // Get the default Realm
            let realm = try Realm()
            
            try! realm.write {
                realm.delete(selectedHeightToDelete)
                
                heightsTableView.reloadData()
            }
            
        } catch let error as NSError {
            print("Error deleting heght from Realm - " + error.description)
        }

    }
    
    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }


}

// MARK:  Extensions

extension HeightReviewListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return heights.count
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let height = heights[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let cell:HeightReviewListCell = self.heightsTableView.dequeueReusableCell(withIdentifier: "HeightReviewListCellID") as! HeightReviewListCell
        
        cell.heightValue.text = String(format: "%.2f", height.value) + " m"
        cell.dateMeasured.text = formatter.string(from: height.dateMeasured! as Date)
        
        // Colour shading
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker
        }
        else {
            cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        }

        return cell
    }
    
}

// MARK: UITableViewDelegate
extension HeightReviewListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedHeightToDelete = heights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        selectedHeightToDelete = heights[indexPath.row]

        if editingStyle == .delete
        {
            askToRemoveHeight()
        }
    }
    
}

