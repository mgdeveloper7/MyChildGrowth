//
//  ChildSelectionVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 23/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class ChildSelectionVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var titleBarNavItem: UINavigationItem!
    
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var childSelectionLabel : UILabel!
    @IBOutlet weak var buttonPodView : UIScrollView!
    
    // Custom outlets
    let customBarButtonAction = UIButton(type: .custom)

    var childProfiles = try! Realm().objects(ChildProfile.self)
    var selectedChildProfile = ChildProfile()
    
   // var selectedChildProfile = ChildProfile.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createLookupTablesIfNotExist()
        
        setupScreen()
        setupColourScheme()
        
        // Show the documents directory incase we need to debug
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsUrl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
  //      refreshButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // On screen startup, refresh buttons at this point since auto layout
        // would have positioned the buttonViewPod
        
        refreshButtons()
        buttonPodView.contentSize = CGSize(width: buttonPodView.frame.size.width, height: buttonPodView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segue Setup
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "AddChildSegue") {
            
             
        }
        
        if (segue.identifier == "ViewChildSegue") {
            let vc:ViewChildVC = segue.destination as! ViewChildVC
            vc.selectedChildProfile = selectedChildProfile
        }

        
    }


    func setupScreen () {
        
        titleBarNavItem.setTitle(title: "MyChildGrowth", subtitle: "Select Child")

        outerScreenImageView.image = UIImage(named: GlobalConstants.ScreenShading.MainBackgroundImageName)
        outerScreenImageView.alpha = GlobalConstants.ScreenShading.BackgroundImageAlpha

        
        // Make round corners for the outerviews
        childSelectionLabel.layer.cornerRadius = 10.0
        childSelectionLabel.clipsToBounds = true
        
        buttonPodView.layer.cornerRadius = 10.0
        buttonPodView.layer.borderWidth = 1
        buttonPodView.layer.borderColor = UIColor.gray.cgColor
        buttonPodView.clipsToBounds = true
        buttonPodView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        buttonPodView.alpha = GlobalConstants.ScreenShading.ViewBackgroundAlpha
        
        buttonPodView.contentSize = CGSize(width: buttonPodView.frame.size.width, height: buttonPodView.frame.size.height)
        
    }
    
    func setRightBarButtonImage () {
        
        customBarButtonAction.setImage(UIImage(named: "Menu"), for: UIControlState.normal)
 //       customBarButtonAction.addTarget(self, action: #selector(ParentWeatherVC.barBtnActionPressed(_:)), for: UIControlEvents.touchUpInside)
        //button.frame = CGRectMake(0, 0, 53, 31)
        customBarButtonAction.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let barButton = UIBarButtonItem(customView: customBarButtonAction)
        titleBarNavItem.rightBarButtonItem = barButton
    }

    
    func refreshButtons() {
        
        // TODO:
        
        childProfiles = try! Realm().objects(ChildProfile.self)
        createChildButtons()

    }
    func setupColourScheme () {
        
//        childSelectionLabel.backgroundColor = GlobalConstants.podDark
//        buttonPodView.backgroundColor = GlobalConstants.podDark
        
//        childSelectionLabel.textColor = UIColor.white
        
    }
    
    func createChildButtons () {
    
        let buttonWidth = 150
        let buttonHeight = 35
        // Outer pod will be centered by autolayout.
        let xPos = (Int(buttonPodView.frame.width) / 2) - (buttonWidth/2)
        var yPos = 10
        
        print(childProfiles)
        
        // Loop through all the buttons in the buttonPodView and remove them
        
        for v in buttonPodView.subviews {
            if v is UIButton{
                v.removeFromSuperview()
            }
        }
        
        if childProfiles.count > 0 {
            for i in 0 ..< childProfiles.count  {
        
                let childProfile = childProfiles[i]
                
                let btn: UIButton = UIButton(frame: CGRect(x: Int(xPos), y: yPos , width: buttonWidth, height: buttonHeight))
                btn.backgroundColor = GlobalConstants.ButtonShading.ButtonBackgroundColor
                btn.setTitle(childProfile.firstname, for: .normal)
                btn.addTarget(self, action: #selector(childButtonPressed), for: .touchUpInside)
                
                btn.tag = i
                btn.layer.borderWidth = 1
                btn.layer.borderColor = GlobalConstants.ButtonShading.ButtonBorderColor
                btn.layer.cornerRadius = GlobalConstants.ButtonShading.ButtonCornerRadius
                btn.clipsToBounds = true
                
                buttonPodView.addSubview(btn)
                yPos = yPos + buttonHeight + 10
            }

        }
        
        // Add an 'Add child button'
        let addChildButton: UIButton = UIButton(frame: CGRect(x: Int(xPos), y: yPos+10 , width: buttonWidth, height: buttonHeight))
        addChildButton.backgroundColor = UIColor.lightGray
        addChildButton.setTitle(NSLocalizedString("Add Child", comment: ""), for: .normal)
        addChildButton.addTarget(self, action: #selector(childButtonPressed), for: .touchUpInside)
        
        addChildButton.tag = 10
        addChildButton.layer.cornerRadius = 5
        buttonPodView.addSubview(addChildButton)
        
        //buttonPodView.contentSize = CGSize(width: buttonPodView.frame.size.width, height: CGFloat(yPos + 20))

    }
    
    func createLookupTablesIfNotExist() {
        
        let innoculationPeriods = try! Realm().objects(VaccineTimePeriodLookup.self)
        
        if innoculationPeriods.count == 0 {

            let dataCreationHelper = DataCreationHelper()
            dataCreationHelper.createVaccineTimePeriodsLookup()
            dataCreationHelper.createVaccineDescriptionsLookup()
            
            
        }
    }
 
    // MARK: Button pressed

    func childButtonPressed(sender: UIButton!) {
        let btnSendTag: UIButton = sender
        
        if btnSendTag.tag == 10 {
            addChild()
        }
        else {
            selectedChildProfile = childProfiles[btnSendTag.tag]
            viewChild()
        }
    }
    
    // MARK: Button related methods
    
    func addChild () {
        
        self.performSegue(withIdentifier: "AddChildSegue", sender: self)
    }
    
    func viewChild () {
        
        self.performSegue(withIdentifier: "ViewChildSegue", sender: self)
    }

    
    // MARK: Realm Related methous
    

}
