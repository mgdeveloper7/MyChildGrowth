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
    
    @IBOutlet weak var titleBar: UINavigationBar!
    @IBOutlet weak var titleBarNavItem: UINavigationItem!
    
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var outerTitleImageView : UIView!
    @IBOutlet weak var childSelectionLabel : UILabel!
    
    @IBOutlet weak var childSelectionOuterView : UIView!
    @IBOutlet weak var addChildButton : UIButton!
    @IBOutlet weak var childSelectionTableView : UITableView!

    // Custom outlets
    let customBarButtonAction = UIButton(type: .custom)

    var childProfiles = try! Realm().objects(ChildProfile.self)
    var selectedChildProfile = ChildProfile()
    
   // var selectedChildProfile = ChildProfile.
    
    // MARK:  Menu
    
    enum Menu: String {
        case ShowSettings = "App Settings"
        case Upgrades = "Purchases"
        case ShowAbout = "About"
        case ShowCancel = "Cancel"
    }

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

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        refreshButtons()
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
        
        outerTitleImageView.layer.cornerRadius = 10.0
        outerTitleImageView.layer.borderWidth = 1
        outerTitleImageView.layer.borderColor = UIColor.gray.cgColor
        outerTitleImageView.clipsToBounds = true
        outerTitleImageView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        outerTitleImageView.alpha = GlobalConstants.ScreenShading.ViewBackgroundAlpha

        childSelectionOuterView.layer.cornerRadius = 10.0
        childSelectionOuterView.layer.borderWidth = 1
        childSelectionOuterView.layer.borderColor = UIColor.gray.cgColor
        childSelectionOuterView.clipsToBounds = true
        childSelectionOuterView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
        
        addChildButton.layer.cornerRadius = 10.0
        addChildButton.layer.borderWidth = 1
        addChildButton.layer.borderColor = UIColor.gray.cgColor
        addChildButton.clipsToBounds = true
        addChildButton.backgroundColor = GlobalConstants.ButtonShading.ButtonBackgroundColor
        addChildButton.setTitleColor(UIColor.white, for: .normal)
        
        childSelectionTableView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter

//        buttonPodView.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
//        buttonPodView.alpha = GlobalConstants.ScreenShading.ViewBackgroundAlpha
//        
        setRightBarButtonImage()
        
    }
    
    func setRightBarButtonImage () {
        
        customBarButtonAction.setImage(UIImage(named: "menu-icon"), for: UIControlState.normal)
        customBarButtonAction.addTarget(self, action: #selector(barBtnActionPressed(_:)), for: UIControlEvents.touchUpInside)
        //button.frame = CGRectMake(0, 0, 53, 31)
        customBarButtonAction.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let barButton = UIBarButtonItem(customView: customBarButtonAction)
        titleBarNavItem.rightBarButtonItem = barButton
    }

    
    func refreshButtons() {
        
        // TODO:
        
        childProfiles = try! Realm().objects(ChildProfile.self)
        childSelectionTableView.reloadData()

    }
    func setupColourScheme () {
        
//        childSelectionLabel.backgroundColor = GlobalConstants.podDark
//        buttonPodView.backgroundColor = GlobalConstants.podDark
        
//        childSelectionLabel.textColor = UIColor.white
        
    }
    
//    func createChildButtons () {
//    
//        let buttonWidth = 150
//        let buttonHeight = 35
//        // Outer pod will be centered by autolayout.
//        let xPos = (Int(buttonPodView.frame.width) / 2) - (buttonWidth/2)
//        var yPos = 10
//        
//        print(childProfiles)
//        
//        // Loop through all the buttons in the buttonPodView and remove them
//        
//        for v in buttonPodView.subviews {
//            if v is UIButton{
//                v.removeFromSuperview()
//            }
//        }
//        
//        if childProfiles.count > 0 {
//            for i in 0 ..< childProfiles.count  {
//        
//                let childProfile = childProfiles[i]
//                
//                let btn: UIButton = UIButton(frame: CGRect(x: Int(xPos), y: yPos , width: buttonWidth, height: buttonHeight))
//                btn.backgroundColor = GlobalConstants.ButtonShading.ButtonBackgroundColor
//                btn.setTitle(childProfile.firstname, for: .normal)
//                btn.addTarget(self, action: #selector(childButtonPressed), for: .touchUpInside)
//                
//                btn.tag = i
//                btn.layer.borderWidth = 1
//                btn.layer.borderColor = GlobalConstants.ButtonShading.ButtonBorderColor
//                btn.layer.cornerRadius = GlobalConstants.ButtonShading.ButtonCornerRadius
//                btn.clipsToBounds = true
//                
//                buttonPodView.addSubview(btn)
//                yPos = yPos + buttonHeight + 10
//            }
//
//        }
//        
//        // Add an 'Add child button'
//        let addChildButton: UIButton = UIButton(frame: CGRect(x: Int(xPos), y: yPos+10 , width: buttonWidth, height: buttonHeight))
//        addChildButton.backgroundColor = UIColor.lightGray
//        addChildButton.setTitle(NSLocalizedString("Add Child", comment: ""), for: .normal)
//        addChildButton.addTarget(self, action: #selector(childButtonPressed), for: .touchUpInside)
//        
//        addChildButton.tag = 10
//        addChildButton.layer.cornerRadius = 5
//        buttonPodView.addSubview(addChildButton)
//        
//        //buttonPodView.contentSize = CGSize(width: buttonPodView.frame.size.width, height: CGFloat(yPos + 20))
//
//    }
    
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

    @IBAction func addChildButtonPressed(_ sender: Any) {
        addChild()
    }

    // MARK: Button related methods
    
    func addChild () {
        
        self.performSegue(withIdentifier: "AddChildSegue", sender: self)
    }
    
    func viewChild () {
        
        self.performSegue(withIdentifier: "ViewChildSegue", sender: self)
    }

    
    // MARK: Realm Related methous
    
    @IBAction func barBtnActionPressed(_ sender: AnyObject) {
        
        let actionMenu = UIAlertController(title: "Menu", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if let popover = actionMenu.popoverPresentationController{
            
            popover.barButtonItem = sender as? UIBarButtonItem
            popover.permittedArrowDirections = UIPopoverArrowDirection.down
            popover.popoverLayoutMargins = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)
        }
        
//        actionMenu.addAction(compassViewAction)
//        
//        if (AppSettings.showThisTimeLastYear) {
//            actionMenu.addAction(thisTimeLastYearAction)
//        }
//        
//        if (AppSettings.showTimeline) {
//            actionMenu.addAction(sunriseSunsetAction)
//        }
        
        actionMenu.addAction(showSettingsAction)
        actionMenu.addAction(upgradesAction)
        actionMenu.addAction(showAboutAction)
        // Adding Cancel allows user to click outside of menu to dismiss alert
        actionMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionMenu, animated: true, completion: nil)
        
    }
    
    // MARK:- Menu action methods
    
//    var compassViewAction: UIAlertAction {
//        return UIAlertAction(title: Menu.CompassView.rawValue, style: .default, handler: { (alert) -> Void in
//            
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "CompassViewSegue", sender: self)
//            }
//        })
//    }
//    
//    var thisTimeLastYearAction: UIAlertAction {
//        return UIAlertAction(title: Menu.ThisTimeLastYear.rawValue, style: .default, handler: { (alert) -> Void in
//            
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "ThisTimeLastYearSegue", sender: self)
//            }
//        })
//    }
//    
//    var sunriseSunsetAction: UIAlertAction {
//        return UIAlertAction(title: Menu.SunriseSunset.rawValue, style: .default, handler: { (alert) -> Void in
//            
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "sunriseSunsetSegue", sender: self)
//            }
//        })
//    }
    
    var showSettingsAction: UIAlertAction {
        return UIAlertAction(title: Menu.ShowSettings.rawValue, style: .default, handler: { (alert) -> Void in
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "settingsScreenSegue", sender: self)
            }
        })
    }
    
    var upgradesAction: UIAlertAction {
        return UIAlertAction(title: Menu.Upgrades.rawValue, style: .default, handler: { (alert) -> Void in
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showUpgradesSegue", sender: self)
            }
        })
    }
    
    var showAboutAction: UIAlertAction {
        return UIAlertAction(title: Menu.ShowAbout.rawValue, style: .default, handler: { (alert) -> Void in
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "aboutScreenSegue", sender: self)
            }
        })
    }

}

// MARK:  Extensions

extension ChildSelectionVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return childProfiles.count
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let child = childProfiles[indexPath.row]
        
        let cell:ChildSelectionCell = self.childSelectionTableView.dequeueReusableCell(withIdentifier: "ChildSelectionCellID") as! ChildSelectionCell
        
        cell.outerView.layer.borderWidth = 1
        cell.outerView.layer.borderColor = GlobalConstants.ButtonShading.ButtonBorderColor
        cell.outerView.layer.cornerRadius = GlobalConstants.ButtonShading.ButtonCornerRadius
        cell.outerView.clipsToBounds = true
        cell.outerView.backgroundColor = GlobalConstants.ButtonShading.ButtonBackgroundColor
        cell.childNameLabel.textColor = UIColor.white
        cell.childNameLabel.text = child.firstname

        // Colour shading
        
//        if (indexPath.row % 2 == 0) {
//            cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker
//        }
//        else {
            cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
//        }
        
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension ChildSelectionVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedChildProfile = childProfiles[indexPath.row]
        viewChild()

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        selectedHeightToDelete = heights[indexPath.row]
//        
//        if editingStyle == .delete
//        {
//            askToRemoveHeight()
//        }
//    }
    
}

