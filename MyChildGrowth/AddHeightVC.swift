//
//  AddHeightVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 31/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class AddHeightVC: UIViewController, ButtonIconViewDelegate, HeightSliderViewDelegate, DatePickerDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var titleBarNavItem: UINavigationItem!
    @IBOutlet weak var outerScreenImageView : UIImageView!
    
    @IBOutlet weak var outerChildDetailView : ChildNameView!    
    @IBOutlet weak var outerButtonView : UIView!
    
    @IBOutlet weak var lastHeightAndDate : UILabel!
    @IBOutlet weak var dateView : ButtonIconView!
    @IBOutlet weak var heightView : ButtonIconView!
    @IBOutlet weak var saveButton : UIButton!

    var heightSliderView : HeightSliderView!
    var datePickerView : DatePicker!
    
    var selectedChildProfile = ChildProfile()
    var selectedHeightDate : NSDate!
    var selectedHeight : Float!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupScreen()
        getLastHeight()
        
        dateView.buildView(width: 105, height: 40, iconImageName: "calendar-icon", withTag: 1)
        dateView.delegate = self
        dateView.layer.cornerRadius = 5
        
        heightView.buildView(width: 105, height: 40, iconImageName: "height-icon", withTag: 2)
        heightView.delegate = self
        heightView.layer.cornerRadius = 5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupScreen() {
        
        titleBarNavItem.setTitle(title: "MyChildGrowth", subtitle: "Add Height")

        outerScreenImageView.image = UIImage(named: GlobalConstants.ScreenShading.MainBackgroundImageName)
        outerScreenImageView.alpha = GlobalConstants.ScreenShading.BackgroundImageAlpha

        outerChildDetailView.layer.cornerRadius = 10.0
        outerChildDetailView.layer.borderWidth = 1
        outerChildDetailView.layer.borderColor = UIColor.gray.cgColor
        outerChildDetailView.clipsToBounds = true
        outerChildDetailView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        outerChildDetailView.alpha = GlobalConstants.ScreenShading.ViewBackgroundAlpha
        
        outerButtonView.layer.cornerRadius = 10.0
        outerButtonView.layer.borderWidth = 1
        outerButtonView.layer.borderColor = UIColor.gray.cgColor
        outerButtonView.clipsToBounds = true
        outerButtonView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        outerButtonView.alpha = GlobalConstants.ScreenShading.ViewBackgroundAlpha
        
        // Buttons
        saveButton.layer.cornerRadius = GlobalConstants.ButtonShading.ButtonCornerRadius
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = GlobalConstants.ButtonShading.ButtonBorderColor
        saveButton.backgroundColor = GlobalConstants.ButtonShading.ButtonBackgroundColor
        saveButton.setTitleColor(GlobalConstants.TableViewAlternateShading.Lighter, for: .normal)
        saveButton.clipsToBounds = true
        
        // Child details and image
        outerChildDetailView.buildView(firstNameString: selectedChildProfile.firstname, lastNameString: selectedChildProfile.surname, sexString: selectedChildProfile.sex)
    }

    func getLastHeight() {
    
        let predicate = NSPredicate(format: "childProfileId == %@", selectedChildProfile.id)
        var heights = try! Realm().objects(Height.self).filter(predicate)
        heights = heights.sorted(byKeyPath: "dateMeasured", ascending: false)
        
        // TODO:  Use Guard Let
        
        if heights.count > 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            let latestHeight = heights.first
            let lastDate = formatter.string(from: latestHeight?.dateMeasured as! Date)

            lastHeightAndDate.text = "Last height: " + String(format: "%.2f", (latestHeight?.value)!) + " m" + " on " + lastDate
        }
        else {
            lastHeightAndDate.text = ""
        }
        
    }
    
    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        if validEntry() {
            saveHeightToRealm()
            
            self.dismiss(animated: true, completion: nil)
        }
        else {
            
            // Let user know that all fields should be entered
            
            let alertView = UIAlertView(title:  NSLocalizedString("Add Height", comment: ""), message: NSLocalizedString("Please ensure that all fields have been entered", comment: ""), delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            
        }
    }

    // MARK:  Save related methods
    
    func validEntry () -> Bool {
        
        // TODO:  Check if a duplicate (date)
 
        if selectedHeightDate == nil {
            return false
        }
        
        if selectedHeight == nil {
            return false
        }

        return true
        
    }

    func saveHeightToRealm() {
        
        let height = Height()
        
        height.id = Utilities.getUniqueIdBasedOnDate()
        height.childProfileId = selectedChildProfile.id
        height.dateMeasured = selectedHeightDate
        height.value = Double(selectedHeight)
        
        do {
            // Get the default Realm
            let realm = try Realm()
            
            // TODO:  detect success
            try! realm.write {
                realm.add(height)
            }
            
        } catch let error as NSError {
            print("Error saving height to Realm - " + error.description)
        }
        
    }


    // MARK:  ButtonIconViewDelegate Methods
    
    func showPicker(buttonIconViewTag : Int) {
        
        if buttonIconViewTag == 1 {
            
            NSLog("Date Picked")
            
            if heightSliderView != nil {
                heightSliderView.removeFromSuperview()
            }
            
            outerChildDetailView.isUserInteractionEnabled = false
            
            datePickerView = DatePicker(frame: CGRect(x: 0, y: 0 , width: self.view.frame.width , height: 170))
            
            datePickerView.delegate = self
            datePickerView.buildPicker()
            let datePickerViewYPos = self.view.frame.size.height - datePickerView.frame.size.height
            
            datePickerView.frame = CGRect(x: datePickerView.frame.origin.x, y: datePickerViewYPos , width: datePickerView.frame.size.width , height: datePickerView.frame.size.height)
            self.view.addSubview(datePickerView);
        }
        else {
            
            if datePickerView != nil {
                datePickerView.removeFromSuperview()
            }
            
            outerChildDetailView.isUserInteractionEnabled = false
            
            heightSliderView = HeightSliderView(frame: CGRect(x: 0, y: 0 , width: self.view.frame.width , height: 200))
            
            heightSliderView.delegate = self
            heightSliderView.buildView(maxHeightValue: 1.5)
            
            // we should know the height of the slider view now, so reposition the view to the bottom
            
            let heightSliderViewYPos = self.view.frame.size.height - heightSliderView.frame.size.height
            
            heightSliderView.frame = CGRect(x: heightSliderView.frame.origin.x, y: heightSliderViewYPos , width: heightSliderView.frame.size.width , height: heightSliderView.frame.size.height)
            
            //   let window = UIApplication.shared.keyWindow!
            //  window.addSubview(weightSliderView)
            
            self.view.addSubview(heightSliderView);
            
        }
        
        
    }
    
    
    // MARK:  HeightSliderViewDelegate Methods
    
    func setHeight(heightInMeters : Float) {
    
        selectedHeight = heightInMeters
        heightView.buttonLabel.text = String(format: "%.2f", selectedHeight) + " m"
    }
    

    // MARK:  DatePickerDelegate Methods
    
    func setDate(selectedDate : NSDate) {
        
        selectedHeightDate = selectedDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        dateView.buttonLabel.text = formatter.string(from: selectedDate as Date)
    }
    
    func enableScreen() {
        outerChildDetailView.isUserInteractionEnabled = true
    }


}
