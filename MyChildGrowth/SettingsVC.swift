//
//  SettingsVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 19/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import MessageUI

class SettingsVC: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var titleBarNavItem: UINavigationItem!
    @IBOutlet weak var outerScreenImageView : UIImageView!
    
//    @IBOutlet weak var outerView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var metricsView: UIView!
    @IBOutlet weak var metricsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightSegmentedControl: UISegmentedControl!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightSegmentedControl: UISegmentedControl!

    @IBOutlet weak var backupDataView: UIView!
    @IBOutlet weak var backupLabel: UILabel!
    @IBOutlet weak var backupEmail: UITextField!
    @IBOutlet weak var backupButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupScreen()
        setupColourScheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupScreen () {
        
        titleBarNavItem.setTitle(title: "MyChildGrowth", subtitle: "Settings")
        
        outerScreenImageView.image = UIImage(named: GlobalConstants.ScreenShading.MainBackgroundImageName)
        outerScreenImageView.alpha = GlobalConstants.ScreenShading.BackgroundImageAlpha
        
        // Make round corners for the outerviews
        
        settingsView.layer.cornerRadius = 10.0
        settingsView.clipsToBounds = true
        settingsView.layer.borderWidth = 1
        settingsView.layer.borderColor = UIColor.darkGray.cgColor
        
        metricsView.layer.cornerRadius = 10.0
        metricsView.clipsToBounds = true
        metricsView.layer.borderWidth = 1
        metricsView.layer.borderColor = UIColor.lightGray.cgColor
        
        backupDataView.layer.cornerRadius = 10.0
        backupDataView.clipsToBounds = true
        backupDataView.layer.borderWidth = 1
        backupDataView.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    func setupColourScheme() {
        
        // let colourScheme = Utility.setupColourScheme()
        
        let textColourScheme = UIColor.black // colourScheme.textColourScheme
        let podColourScheme = GlobalConstants.TableViewAlternateShading.Lighter
        // colourScheme.podColourScheme
        
        // Labels
        metricsLabel.textColor = textColourScheme
        weightLabel.textColor = textColourScheme
        heightLabel.textColor = textColourScheme
        backupLabel.textColor = textColourScheme
        
        // Pods
        settingsView.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker
        metricsView.backgroundColor = podColourScheme
        backupDataView.backgroundColor = podColourScheme
        
        settingsView.alpha = CGFloat(GlobalConstants.ScreenShading.ViewBackgroundAlpha)
        metricsView.alpha = CGFloat(GlobalConstants.ScreenShading.ViewBackgroundAlpha)
        backupDataView.alpha = CGFloat(GlobalConstants.ScreenShading.ViewBackgroundAlpha)
    
    }


    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backupButtonPressed(_ sender: AnyObject) {
        
        emailRealmFile()
    }
    
    // MARK:  Data Backup related methods
    
    func emailRealmFile() {
        
        // Get the default realm file from the documents directory and send it as an email to the given address
        sendEmail()
    }
    
    func sendEmail() {
        
        // Get the Realm file for backup
        let filePath = Utility.getDocumentsDirectoryURL().path + "/" + GlobalConstants.Realm.DefaultRealm
        print("Realm filepath: " + filePath)
        
//        if let fileData = NSData(contentsOfFile: filePath) {
//            print("File data loaded.")
//        }

        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([backupEmail.text!])
            
            let messageBody = "Backup of app data"
            mail.setSubject("MyChildGrowth App Data Backup")
            mail.setMessageBody(messageBody, isHTML: true)
            
            if let fileData = NSData(contentsOfFile: filePath) {
                print("File data loaded.")
                mail.addAttachmentData(fileData as Data, mimeType: "realm", fileName: "backup.mcg")
            }
           
            present(mail, animated: true)
        } else {
            // show failure alert
            
            let messageText = "Sorry, your device has not been set up to send emails."
            Utility.showMessage(titleString: "Email Error", messageString: messageText )
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
