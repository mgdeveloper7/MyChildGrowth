//
//  AddChildVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 24/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class AddChildVC: UIViewController, WeightSliderViewDelegate, ButtonIconViewDelegate, DatePickerDelegate, UITextFieldDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var outerScreenImageView : UIImageView!

    @IBOutlet weak var outerChildDetailView : UIView!
    @IBOutlet weak var firstname : UITextField!
    @IBOutlet weak var surname : UITextField!
    @IBOutlet weak var sexSegmentedControl : UISegmentedControl!
    @IBOutlet weak var dateView : ButtonIconView!
    @IBOutlet weak var weightView : ButtonIconView!

    @IBOutlet weak var saveButton : UIButton!

    var selectedDateOfBirth : NSDate!
    var selectedWeightAtBirth : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupScreen()
        
        dateView.buildView(width: 120, height: 30, iconImageName: "calendar-icon", withTag: 1)
        dateView.delegate = self
        dateView.layer.cornerRadius = 5

        weightView.buildView(width: 120, height: 30, iconImageName: "weight-icon", withTag: 2)
        weightView.delegate = self
        weightView.layer.cornerRadius = 5
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScreen() {
        
        outerChildDetailView.layer.cornerRadius = 10.0
        outerChildDetailView.layer.borderWidth = 1
        outerChildDetailView.layer.borderColor = UIColor.gray.cgColor
        outerChildDetailView.clipsToBounds = true
        
        // Buttons
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.lightGray.cgColor

        // Delegates
        firstname.delegate = self
        surname.delegate = self
    }
    
    func saveChildToRealm() {
        
       // let utils = Utilities()
        
        let childProfile = ChildProfile()
        
        childProfile.id = Utilities.getUniqueIdBasedOnDate()
        childProfile.firstname = self.firstname.text!
        childProfile.surname = self.surname.text!
        childProfile.dateOfBirth = self.selectedDateOfBirth
        
        if sexSegmentedControl.selectedSegmentIndex == 0 {
            childProfile.sex = NSLocalizedString("Male", comment: "")
        }
        else {
            childProfile.sex = NSLocalizedString("Female", comment: "")
        }

        childProfile.weightAtBirth = Double(selectedWeightAtBirth)

        do {
            // Get the default Realm
           let realm = try Realm()
            
            try! realm.write {
                realm.add(childProfile)
            }

        } catch let error as NSError {
            print("Error saving childProfile to Realm - " + error.description)
        }

    }
    
    func validEntry () -> Bool {
        
        // TODO:  Check if a duplicate (surname, dob?)
        // TODO:  Check if all fields entered
        
        if firstname.text == "" {
            return false
        }
 
        if surname.text == "" {
            return false
        }

        if weightView.buttonLabel?.text! == "" {
            return false
        }

        return true
        
    }
    

    @IBAction func sexSegmentedControlChanged(_ sender: Any) {
        view.endEditing(true)
        
        //        if segment.selectedSegmentIndex == 0 {
        //        }


    }

    
    // MARK:  Keyboard functions
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func dateButtonPressed(_ sender: AnyObject) {

        outerChildDetailView.isUserInteractionEnabled = false

        showPicker(buttonIconViewTag: sender.tag)
    }
    

    @IBAction func saveButtonPressed(_ sender: AnyObject) {

        if validEntry() {
            saveChildToRealm()
            
            self.dismiss(animated: true, completion: nil)
        }
        else {
            
            // Let user know that all fields should be entered
            
            let alertView = UIAlertView(title:  NSLocalizedString("Add Child", comment: ""), message: NSLocalizedString("Please ensure that all fields have been entered", comment: ""), delegate: nil, cancelButtonTitle: "OK")
            alertView.show()

        }
    }

    func showDatePicker() {
        
        outerChildDetailView.isUserInteractionEnabled = false
        
        var datePickerView = DatePicker(frame: CGRect(x: 0, y: 0 , width: self.view.frame.width , height: 170))
        
        datePickerView.delegate = self
        datePickerView.buildPicker()
        let datePickerViewYPos = self.view.frame.size.height - datePickerView.frame.size.height
        
        datePickerView.frame = CGRect(x: datePickerView.frame.origin.x, y: datePickerViewYPos , width: datePickerView.frame.size.width , height: datePickerView.frame.size.height)
        self.view.addSubview(datePickerView);

    }
    
    func showWeightPicker() {

        outerChildDetailView.isUserInteractionEnabled = false
        
        var weightSliderView = WeightSliderView(frame: CGRect(x: 0, y: 0 , width: self.view.frame.width , height: 200))
        
        weightSliderView.delegate = self
        weightSliderView.buildView(maxWeightValue: 10)
        
        // we should know the height of the slider view now, so reposition the view to the bottom
        
        let weightSliderViewYPos = self.view.frame.size.height - weightSliderView.frame.size.height
        
        weightSliderView.frame = CGRect(x: weightSliderView.frame.origin.x, y: weightSliderViewYPos , width: weightSliderView.frame.size.width , height: weightSliderView.frame.size.height)
        
        //   let window = UIApplication.shared.keyWindow!
        //  window.addSubview(weightSliderView)
        
        self.view.addSubview(weightSliderView);

    }
    
    // MARK:  WeightSliderViewDelegate Methods

    func setWeight(kgWeight : Int) {
        
        selectedWeightAtBirth = kgWeight
        weightView.buttonLabel.text = String(kgWeight) + " kg"
    }
    
    func enableScreen() {
        outerChildDetailView.isUserInteractionEnabled = true
    }
    
    // MARK:  ButtonIconViewDelegate Methods
    
    func showPicker(buttonIconViewTag : Int) {
        
        if buttonIconViewTag == 1 {
            showDatePicker()
        }
        else {
            showWeightPicker()
        }
        
    }

    // MARK:  DatePickerDelegate Methods

    func setDate(selectedDate : NSDate) {
        
        selectedDateOfBirth = selectedDate

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"

        dateView.buttonLabel.text = formatter.string(from: selectedDate as Date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
