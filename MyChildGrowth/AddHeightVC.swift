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
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var outerChildDetailView : UIView!
    @IBOutlet weak var genderImage : UIImageView!
    @IBOutlet weak var firstname : UILabel!
    @IBOutlet weak var surname : UILabel!
    
    @IBOutlet weak var outerButtonView : UIView!
    @IBOutlet weak var dateView : ButtonIconView!
    @IBOutlet weak var heightView : ButtonIconView!
    @IBOutlet weak var saveButton : UIButton!

    var selectedChildProfile = ChildProfile()
    var selectedHeightDate : NSDate!
    var selectedHeight : Float!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupScreen()
        
        dateView.buildView(iconImageName: "calendar-icon", withTag: 1)
        dateView.delegate = self
        dateView.layer.cornerRadius = 5
        
        heightView.buildView(iconImageName: "height-icon", withTag: 2)
        heightView.delegate = self
        heightView.layer.cornerRadius = 5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupScreen() {
        
        outerButtonView.layer.cornerRadius = 10.0
        outerButtonView.layer.borderWidth = 1
        outerButtonView.layer.borderColor = UIColor.gray.cgColor
        outerButtonView.clipsToBounds = true
        
        // Buttons
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        
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
 
        if dateView.buttonLabel?.text! == "" {
            return false
        }
        
        if heightView.buttonLabel?.text! == "" {
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
            outerChildDetailView.isUserInteractionEnabled = false
            
            var datePickerView = DatePicker(frame: CGRect(x: 0, y: 0 , width: self.view.frame.width , height: 170))
            
            datePickerView.delegate = self
            datePickerView.buildPicker()
            let datePickerViewYPos = self.view.frame.size.height - datePickerView.frame.size.height
            
            datePickerView.frame = CGRect(x: datePickerView.frame.origin.x, y: datePickerViewYPos , width: datePickerView.frame.size.width , height: datePickerView.frame.size.height)
            self.view.addSubview(datePickerView);
        }
        else {
            
            outerChildDetailView.isUserInteractionEnabled = false
            
            var heightSliderView = HeightSliderView(frame: CGRect(x: 0, y: 0 , width: self.view.frame.width , height: 200))
            
            heightSliderView.delegate = self
            heightSliderView.buildView()
            
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
