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
    @IBOutlet weak var dateOfBirth : UILabel!
    @IBOutlet weak var weightAtBirth : UILabel!
    
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
    
        // Buttons
        addHeightButton.layer.cornerRadius = 10.0
        addHeightButton.layer.borderWidth = 1
        addHeightButton.layer.borderColor = UIColor.lightGray.cgColor

    }
    // MARK: Segue Setup
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "AddHeightSegue") {
            
            let vc:AddHeightVC = segue.destination as! AddHeightVC
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
