//
//  HeightChartVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 31/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit
import RealmSwift

class HeightChartVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var outerChildDetailView : UIView!
    @IBOutlet weak var genderImage : UIImageView!
    @IBOutlet weak var firstname : UILabel!
    @IBOutlet weak var surname : UILabel!
    
    @IBOutlet weak var outerChartView : UIView!
    @IBOutlet weak var growthSince : UILabel!
    
    @IBOutlet weak var outerButtonView : UIView!
    @IBOutlet weak var lineChart: LineChart!
    @IBOutlet weak var addHeightButton : UIButton!

    var selectedChildProfile = ChildProfile()
    var heights : Results<Height>!
    var monthsAndYears : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupScreen()
        
        getHeightsForChild()
        drawChart()
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
        
        lineChart.layer.cornerRadius = 5.0
        lineChart.layer.borderWidth = 1
        lineChart.layer.borderColor = UIColor.lightGray.cgColor
        lineChart.clipsToBounds = true
//        outerChartView.alpha = 0.6


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
    
    
    func getHeightsForChild() {
        
        // TODO: Add to HeightHelper class
        
        let predicate = NSPredicate(format: "childProfileId == %@", selectedChildProfile.id)
        heights = try! Realm().objects(Height.self).filter(predicate)
        heights = heights!.sorted(byKeyPath: "dateMeasured", ascending: true)
        
    }

    
    // MARK:  Line Chart related methods
    
    func drawChart() {
        
        let f: (CGFloat) -> CGPoint = {

            let xVal = self.getMonthsAndYearsBetween(startDate: self.selectedChildProfile.dateOfBirth! as Date, endDate: self.heights[Int($0)].dateMeasured! as Date)
            var yVal = self.heights[Int($0)].value
            
            yVal = yVal * 100.0
            
            return CGPoint(x: CGFloat(xVal), y: CGFloat(yVal))
        }
               
        let noPoints = (heights.count)
        
        let xs = [Int](0..<noPoints)
        
        let points = xs.map({f(CGFloat($0))})
        
        lineChart.deltaX = 1
        lineChart.deltaY = 20
        
        lineChart.circleColor = UIColor.red
        lineChart.showInnerLines = false
        lineChart.circleSizeMultiplier = 5
        lineChart.lineWidth = 4

  //      lineChart.setAxisRange(xMin: 0, xMax: 13, yMin: 20, yMax: 120)
        lineChart.plot(points)
        
        // Add the date the first height was captured
        
        guard let firstMeasuredDate = heights.first?.dateMeasured else {
            growthSince.text = "No previous heighs recorded"
            return
        }
        
        let monthSinceBirthday = getMonthsAndYearsBetween(startDate: selectedChildProfile.dateOfBirth! as Date, endDate: firstMeasuredDate as Date)
        
        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = "dd/MM/yyyy"

        growthSince.text = "Growth since " + dateFormtter.string(from: firstMeasuredDate as Date) + " (Month " + String(monthSinceBirthday) + ")"
    }

    func getMonthsAndYearsBetween(startDate : Date, endDate : Date) -> Int {
        
        let calendar = Calendar.current
        let dateFormtter = DateFormatter()

        dateFormtter.dateFormat = "MMMM yyyy"
        
        // Create the matching conponent : day 1 of each month
        let components = DateComponents(day: 1)
        // The variable result will contain the array of month names,
        var result = [dateFormtter.string(from: startDate)]
        
        // this particular method of Calendar enumerates each date matching the components
        calendar.enumerateDates(startingAfter: startDate, matching: components, matchingPolicy: .nextTime) { (date, strict, stop) in
            result.append(dateFormtter.string(from: date!))
            // exit the enumeration if the end date is reached
            if date! >= endDate { stop = true }
        }
        
        return result.count
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

