//
//  ViewChildVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 26/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewChildVC: UIViewController, GADBannerViewDelegate {

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

    // The banner views.
    @IBOutlet weak var bannerOuterView: UIView!
    @IBOutlet weak var closeBannerButton : UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var selectedChildProfile = ChildProfile()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bannerOuterView.isHidden = true
        setupScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AppSettings.ShowBannerAds {
            
            // For this screen we only want to randomly show the banner ad, so thats its an
            // occasional annoyance
            bannerOuterView.isHidden = true
            let rand = Int(arc4random_uniform(4))
            if (rand % GlobalConstants.BannerAdDisplayFrequency == 0) {
                loadBannerAd()
                bannerOuterView.isHidden = false
            }
        }
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
    
    // MARK:  Banner Ad Methods
    
    func loadBannerAd() {
        
        bannerView.delegate = self
        bannerView.adUnitID = AppSettings.AdMobBannerID
        bannerView.rootViewController = self
        bannerView.load(BannerAdHelper.getGADRequest())
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
    
    @IBAction func closeBannerAdButtonPressed(_ sender: AnyObject) {
        
        // Dismiss banner ad view
        bannerOuterView.isHidden = true
    }
    
    // MARK:  GADBannerViewDelegate methods
    
    // Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Ad has been received")
        
        // show the delete ad button
        closeBannerButton.isHidden = false
    }

}
