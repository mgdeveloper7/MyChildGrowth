//
//  ViewChildVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 26/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class ViewChildVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var outerChildDetailView : UIView!
    @IBOutlet weak var genderImage : UIImageView!
    @IBOutlet weak var firstname : UILabel!
    @IBOutlet weak var surname : UILabel!
    @IBOutlet weak var dateOfBirth : UILabel!
    @IBOutlet weak var weightAtBirth : UILabel!
    
    @IBOutlet weak var outerButtonView : UIView!
    @IBOutlet weak var innoculationsButton : UIButton!
    @IBOutlet weak var heightEntryButton : UIButton!
    @IBOutlet weak var weightEntryButton : UIButton!

    var selectedChildProfile = ChildProfile()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segue Setup
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "HeightChartSegue") {
            
            let vc:HeightChartVC = segue.destination as! HeightChartVC
            vc.selectedChildProfile = selectedChildProfile
            
        }
    }

    func setupScreen() {
        
        outerChildDetailView.layer.cornerRadius = 10.0
        outerChildDetailView.layer.borderWidth = 1
        outerChildDetailView.layer.borderColor = UIColor.gray.cgColor
        outerChildDetailView.clipsToBounds = true

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
        
        if selectedChildProfile.dateOfBirth != nil {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            self.dateOfBirth.text = formatter.string(from: selectedChildProfile.dateOfBirth! as Date)
        }

        self.weightAtBirth.text = String(Int(selectedChildProfile.weightAtBirth)) + " kg"
        
        outerButtonView.layer.cornerRadius = 10.0
        outerButtonView.layer.borderWidth = 1
        outerButtonView.layer.borderColor = UIColor.gray.cgColor
        outerButtonView.clipsToBounds = true
        
        // Buttons
        innoculationsButton.layer.cornerRadius = 10.0
        innoculationsButton.layer.borderWidth = 1
        innoculationsButton.layer.borderColor = UIColor.lightGray.cgColor
        heightEntryButton.layer.cornerRadius = 10.0
        heightEntryButton.layer.borderWidth = 1
        heightEntryButton.layer.borderColor = UIColor.lightGray.cgColor
        weightEntryButton.layer.cornerRadius = 10.0
        weightEntryButton.layer.borderWidth = 1
        weightEntryButton.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func innoculationsButtonPressed(_ sender: AnyObject) {

    }

    @IBAction func heightButtonPressed(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "HeightChartSegue", sender: self)
        
    }

    @IBAction func weightButtonPressed(_ sender: AnyObject) {
        
    }
}
