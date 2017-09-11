//
//  ChildNameView.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 07/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class ChildNameView: UIView {

    var outerChildDetailView : UIView!
    var genderImage : UIImageView!
    var firstname : UILabel!
    var surname : UILabel!

    func buildView(firstNameString : String, lastNameString : String, sexString : String) {
        
        self.frame =  CGRect(x: 0 , y: self.frame.origin.y , width: self.frame.width, height: self.frame.height)
        
        var xPos = 0
        var yPos = 5

        /** Child Image */
        
        var imageName : String!
        
        if sexString == "Male" {
            imageName = "boy-icon"
        }
        else {
            imageName = "girl-icon"
        }

        let childImage = UIImage(named: imageName)
        
        genderImage = UIImageView(frame: CGRect(x: xPos, y: yPos , width: 42, height: 42))
        genderImage.image = childImage
        genderImage.contentMode = .scaleAspectFit
        self.addSubview(genderImage)

        /** First Name */
        xPos = Int(genderImage.frame.size.width) + 7
        
        firstname = UILabel(frame: CGRect(x: xPos, y: yPos , width: 200, height: 25))
        firstname.text = firstNameString
        firstname.textAlignment = NSTextAlignment.left
        firstname.font = UIFont.boldSystemFont(ofSize: firstname.font.pointSize+5)
        self.addSubview(firstname)

        /** Last Name */
        yPos = Int(firstname.frame.size.height) + 5
        
        surname = UILabel(frame: CGRect(x: xPos, y: yPos , width: 200, height: 15))
        surname.text = lastNameString
        surname.textAlignment = NSTextAlignment.left
        surname.font = UIFont.systemFont(ofSize: surname.font.pointSize-3, weight: UIFontWeightThin)
        self.addSubview(surname)

        yPos = Int(surname.frame.size.height) + 1

        // Resize view
        self.frame =  CGRect(x: self.frame.origin.x , y: self.frame.origin.y , width: 300, height: CGFloat(yPos))

    }

}
