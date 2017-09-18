//
//  AboutVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 18/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var titleBarNavItem: UINavigationItem!
    @IBOutlet weak var outerScreenImageView : UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
//    @IBOutlet weak var weatherImage : UIImageView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var aboutTitle: UILabel!
    @IBOutlet weak var aboutVersion: UILabel!
    @IBOutlet weak var aboutAuthor: UILabel!
    @IBOutlet weak var aboutDescription: UILabel!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var supportFeedbackTitle: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var creditsView: UIView!
    @IBOutlet weak var creditsTitle: UILabel!
    @IBOutlet weak var weatherSource: UITextView!
    @IBOutlet weak var iconSource: UITextView!
    @IBOutlet weak var photoSource: UITextView!
    
    @IBOutlet weak var changeLogButton: UIButton!
    
    /// The banner view.
//    @IBOutlet weak var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScreen () {
        
        titleBarNavItem.setTitle(title: "MyChildGrowth", subtitle: "About")
        
        outerScreenImageView.image = UIImage(named: GlobalConstants.ScreenShading.MainBackgroundImageName)
        outerScreenImageView.alpha = GlobalConstants.ScreenShading.BackgroundImageAlpha
        
    }
    
    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }



}
