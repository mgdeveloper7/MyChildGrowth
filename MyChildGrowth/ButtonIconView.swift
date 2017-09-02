//
//  ButtonIconView.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 01/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

protocol ButtonIconViewDelegate
{
    func showPicker(buttonIconViewTag : Int)
}

class ButtonIconView: UIView {

    var delegate:ButtonIconViewDelegate?
    
    // MARK: Outlets
    
    var buttonLabel : UILabel!
    var buttonIconOuterButton : UIButton!
    var buttonIcon : UIImageView!
    var tmp : UITextField!
    
    // MARK: Other variables
    var buttonIconViewTag : Int!
    
    func buildView (iconImageName : String, withTag : Int) {
        
        let labelWidth = 120
        let labelHeight = 30
        var xPos = 0
        let yPos = 0
        
        buttonIconViewTag = withTag
        
        /** Label Padding */
        
        let padding = UILabel(frame: CGRect(x: xPos, y: yPos , width: 7, height: labelHeight))
        self.addSubview(padding)
        xPos = 7
        
        /** Button Label */
        
        buttonLabel = UILabel(frame: CGRect(x: xPos, y: yPos , width: labelWidth, height: labelHeight))
        buttonLabel.backgroundColor = UIColor.white
        
        self.addSubview(buttonLabel)
        
        /** Button icon outer button */
        
        xPos = Int(buttonLabel.frame.size.width)
        buttonIconOuterButton = UIButton(frame: CGRect(x: xPos, y: yPos , width: 30, height: labelHeight))
        buttonIconOuterButton.backgroundColor = GlobalConstants.dateViewShade
        buttonIconOuterButton.addTarget(self, action: #selector(buttonIconPressed), for: UIControlEvents.touchUpInside)
        
        self.addSubview(buttonIconOuterButton)
        
        /** Icon  */
        
        let imageName = iconImageName
        let image = UIImage(named: imageName)
        
        let imageXPos = Int(buttonIconOuterButton.frame.origin.x) + 5
        let imageYPos = 5
        
        buttonIcon = UIImageView(frame: CGRect(x: imageXPos , y: imageYPos , width: 20, height: 20))
        buttonIcon.image = image
        
        self.addSubview(buttonIcon)
        
        // Resize view
        
        let newWidth = xPos + Int(buttonIconOuterButton.frame.size.width)
        let newHeight = yPos + Int(buttonLabel.frame.size.height)
        
        self.frame =  CGRect(x: self.frame.origin.x , y: self.frame.origin.y , width: CGFloat(newWidth), height: CGFloat(newHeight))
        
    }
    
    // MARK:  Button Press methods
    
    func buttonIconPressed(sender:UIButton!) {
        NSLog("buttonIcon Pressed")
        
        delegate?.showPicker(buttonIconViewTag: buttonIconViewTag)
        
    }
    

}
