//
//  DateView.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 24/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class DateView: UIView {

    // MARK: Outlets
    
    var dateLabel : UILabel!
    var dateIconOuterButton : UIButton!
    var dateIcon : UIImageView!
    
    func buildView () {
        
        let labelWidth = 120
        let labelHeight = 30
        var xPos = 0
        var yPos = 0
        
        /** Date Label */
        
        dateLabel = UILabel(frame: CGRect(x: xPos, y: yPos , width: labelWidth, height: labelHeight))
        dateLabel.backgroundColor = UIColor.white
        //dateLabel.text = "(Enter DOB)"
        
        self.addSubview(dateLabel)
        
        /** Date icon outer button */

        xPos = Int(dateLabel.frame.size.width)
        dateIconOuterButton = UIButton(frame: CGRect(x: xPos, y: yPos , width: 30, height: labelHeight))
        dateIconOuterButton.backgroundColor = GlobalConstants.dateViewShade
        dateIconOuterButton.addTarget(self, action: #selector(calendarPressed), for: .touchUpInside)

        self.addSubview(dateIconOuterButton)
        
        /** Date icon  */
        
        let imageName = "calendar-icon"
        let image = UIImage(named: imageName)
        
        xPos = Int(dateIconOuterButton.frame.origin.x) + 5
        yPos = 5
        
        dateIcon = UIImageView(frame: CGRect(x: xPos , y: yPos , width: 20, height: 20))
        dateIcon.image = image
        
//        self.addSubview(dateIcon)

    }
    
    // MARK:  Button Press methods

    func calendarPressed(sender : UIButton) {

        NSLog("Calendar pressed")
    }
}
