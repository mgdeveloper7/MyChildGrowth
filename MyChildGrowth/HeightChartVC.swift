//
//  HeightChartVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 31/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class HeightChartVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var outerChildDetailView : UIView!
    @IBOutlet weak var genderImage : UIImageView!
    @IBOutlet weak var firstname : UILabel!
    @IBOutlet weak var surname : UILabel!
    
    @IBOutlet weak var outerChartView : UIView!

    @IBOutlet weak var outerButtonView : UIView!
    @IBOutlet weak var addHeightButton : UIButton!

    
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
    

    func setupScreen() {
    
        // Views
        outerChartView.layer.cornerRadius = 10.0
        outerChartView.layer.borderWidth = 1
        outerChartView.layer.borderColor = UIColor.lightGray.cgColor
        outerChartView.alpha = 0.6

        // Buttons
        addHeightButton.layer.cornerRadius = 10.0
        addHeightButton.layer.borderWidth = 1
        addHeightButton.layer.borderColor = UIColor.lightGray.cgColor
        
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

    }
    // MARK: Segue Setup
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "AddHeightSegue") {
            
            let vc:AddHeightVC = segue.destination as! AddHeightVC
            vc.selectedChildProfile = selectedChildProfile
            
        }
        
        if (segue.identifier == "ListHeightSegue") {
            
            let vc:HeightReviewListVC = segue.destination as! HeightReviewListVC
            vc.selectedChildProfile = selectedChildProfile
            
        }

    }
    
    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func ListHeightButtonPressed(_ sender: AnyObject) {

        self.performSegue(withIdentifier: "ListHeightSegue", sender: self)
    }
    
    @IBAction func AddHeightButtonPressed(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "AddHeightSegue", sender: self)
    }
    

}
