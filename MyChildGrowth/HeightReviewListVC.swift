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
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var outerChildDetailView : UIView!
    @IBOutlet weak var genderImage : UIImageView!
    @IBOutlet weak var firstname : UILabel!
    @IBOutlet weak var surname : UILabel!
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

        // Tableview
        
        heightsTableView.layer.cornerRadius = 10.0
        heightsTableView.layer.borderWidth = 1
        heightsTableView.layer.borderColor = UIColor.lightGray.cgColor
        heightsTableView.allowsSelection = false
        
        heightsTableView.alpha = 0.6

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
        return tableView.rowHeight-2
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

