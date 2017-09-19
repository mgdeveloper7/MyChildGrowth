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
    
    @IBOutlet weak var titleBarNavItem: UINavigationItem!
    
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
        
        if (segue.identifier == "InnoculationsSegue") {
            
            let vc:InnoculationsVC = segue.destination as! InnoculationsVC
            vc.selectedChildProfile = selectedChildProfile
            
        }

        if (segue.identifier == "HeightChartSegue") {
            
            let vc:HeightChartVC = segue.destination as! HeightChartVC
            vc.selectedChildProfile = selectedChildProfile
            
        }
    }

    func setupScreen() {
        
        titleBarNavItem.setTitle(title: "MyChildGrowth", subtitle: "View Child")

        outerScreenImageView.image = UIImage(named: GlobalConstants.ScreenShading.MainBackgroundImageName)
        outerScreenImageView.alpha = GlobalConstants.ScreenShading.BackgroundImageAlpha

        // Buttons
        outerChildDetailView.layer.cornerRadius = 10.0
        outerChildDetailView.layer.borderWidth = 1
        outerChildDetailView.layer.borderColor = UIColor.gray.cgColor
        outerChildDetailView.clipsToBounds = true
        outerChildDetailView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        outerChildDetailView.alpha = GlobalConstants.ScreenShading.ViewBackgroundAlpha
        
        // Child details and image
        self.firstname.text = selectedChildProfile.firstname
        self.surname.text = selectedChildProfile.surname
 
        genderImage.image = UIImage(named: Utility.getChildIcon(sex: selectedChildProfile.sex as NSString))

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
        outerButtonView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        outerButtonView.alpha = 0.9

        
        // Buttons
        innoculationsButton.layer.cornerRadius = GlobalConstants.ButtonShading.ButtonCornerRadius
        innoculationsButton.layer.borderWidth = 1
        innoculationsButton.layer.borderColor = GlobalConstants.ButtonShading.ButtonBorderColor
        innoculationsButton.backgroundColor = GlobalConstants.ButtonShading.ButtonBackgroundColor
        innoculationsButton.setTitleColor(GlobalConstants.TableViewAlternateShading.Lighter, for: .normal)

        heightEntryButton.layer.cornerRadius = GlobalConstants.ButtonShading.ButtonCornerRadius
        heightEntryButton.layer.borderWidth = 1
        heightEntryButton.layer.borderColor = GlobalConstants.ButtonShading.ButtonBorderColor
        heightEntryButton.backgroundColor = GlobalConstants.ButtonShading.ButtonBackgroundColor
        heightEntryButton.setTitleColor(GlobalConstants.TableViewAlternateShading.Lighter, for: .normal)
        heightEntryButton.clipsToBounds = true

        weightEntryButton.layer.cornerRadius = GlobalConstants.ButtonShading.ButtonCornerRadius
        weightEntryButton.layer.borderWidth = 1
        weightEntryButton.layer.borderColor = GlobalConstants.ButtonShading.ButtonBorderColor
        weightEntryButton.backgroundColor = GlobalConstants.ButtonShading.ButtonBackgroundColor
        weightEntryButton.setTitleColor(GlobalConstants.TableViewAlternateShading.Lighter, for: .normal)

    }
    
    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func innoculationsButtonPressed(_ sender: AnyObject) {

        self.performSegue(withIdentifier: "InnoculationsSegue", sender: self)
        
    }

    @IBAction func heightButtonPressed(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "HeightChartSegue", sender: self)
        
    }

    @IBAction func weightButtonPressed(_ sender: AnyObject) {
        
    }
}
