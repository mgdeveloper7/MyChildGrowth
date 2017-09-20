//
//  AboutVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 18/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import GoogleMobileAds

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
    @IBOutlet weak var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupScreen()
        setupColourScheme()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if AppSettings.ShowBannerAds {
            loadBannerAd()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScreen () {
        
        titleBarNavItem.setTitle(title: "MyChildGrowth", subtitle: "About")
        
        outerScreenImageView.image = UIImage(named: GlobalConstants.ScreenShading.MainBackgroundImageName)
        outerScreenImageView.alpha = GlobalConstants.ScreenShading.BackgroundImageAlpha
        
        // Make round corners for the outerviews
        
        aboutView.layer.cornerRadius = 10.0
        aboutView.clipsToBounds = true
        
        emailView.layer.cornerRadius = 10.0
        emailView.clipsToBounds = true
        
        creditsView.layer.cornerRadius = 10.0
        creditsView.clipsToBounds = true
        
        // Make corners for the textviews, for effect
        emailButton.layer.cornerRadius = 10.0
        emailButton.clipsToBounds = true
        
        weatherSource.layer.cornerRadius = 10.0
        weatherSource.clipsToBounds = true
        
        iconSource.layer.cornerRadius = 10.0
        iconSource.clipsToBounds = true
        
        photoSource.layer.cornerRadius = 10.0
        photoSource.clipsToBounds = true
        
        aboutTitle.text = GlobalConstants.AppName
        aboutVersion.text = "Version " + Utility.getBuildVersion()
        aboutDescription.text = "Monitor your childs growth and keep track of their innoculations."
        
        // Make the label to the credits clickable
//        let urlString = "Weather API Powered By Dark Sky"
//        let attributedString = NSMutableAttributedString(string: urlString)
//        attributedString.addAttribute(NSLinkAttributeName, value: GlobalConstants.DarkSkyURL, range: NSRange(location: 0, length: urlString.characters.count))
//        weatherSource.attributedText = attributedString
        
        let iconUrlString = "App icons from Icons8"
        let iconAttributedString = NSMutableAttributedString(string: iconUrlString)
        iconAttributedString.addAttribute(NSLinkAttributeName, value: GlobalConstants.WeatherIconURL, range: NSRange(location: 0, length: iconUrlString.characters.count))
        iconSource.attributedText = iconAttributedString
        
        let photosUrlString = "Photos from Pexels"
        let photosAttributedString = NSMutableAttributedString(string: photosUrlString)
        photosAttributedString.addAttribute(NSLinkAttributeName, value: GlobalConstants.WeatherPhotosURL, range: NSRange(location: 0, length: photosUrlString.characters.count))
        photoSource.attributedText = photosAttributedString


    }
    
    func setupColourScheme() {
        
       // let colourScheme = Utility.setupColourScheme()
        
        let textColourScheme = UIColor.black // colourScheme.textColourScheme
        let podColourScheme = GlobalConstants.TableViewAlternateShading.Lighter
 // colourScheme.podColourScheme
        
        // Labels
        aboutTitle.textColor = textColourScheme
        aboutVersion.textColor = textColourScheme
        aboutAuthor.textColor = textColourScheme
        aboutDescription.textColor = textColourScheme
        supportFeedbackTitle.textColor = textColourScheme
        creditsTitle.textColor = textColourScheme
        weatherSource.textColor = textColourScheme
        iconSource.textColor = textColourScheme
        photoSource.textColor = textColourScheme
        
        // Pods
        creditsView.backgroundColor = podColourScheme
        aboutView.backgroundColor = podColourScheme
        emailView.backgroundColor = podColourScheme
        
        creditsView.alpha = CGFloat(GlobalConstants.ScreenShading.ViewBackgroundAlpha) - 0.1
        aboutView.alpha = CGFloat(GlobalConstants.ScreenShading.ViewBackgroundAlpha) - 0.1
        emailView.alpha = CGFloat(GlobalConstants.ScreenShading.ViewBackgroundAlpha) - 0.1
        
        // Buttons and Title Labels
        emailButton.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker //   podColourScheme
        
        weatherSource.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker // podColourScheme
        iconSource.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker //podColourScheme
        photoSource.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker //podColourScheme
        
    }

    // MARK:  Banner Ad Methods
    
    func loadBannerAd() {
        
        bannerView.adUnitID = AppSettings.AdMobBannerID
        bannerView.rootViewController = self
        bannerView.load(BannerAdHelper.getGADRequest())
    }

    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }



}
