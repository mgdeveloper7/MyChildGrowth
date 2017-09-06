//
//  WeightSliderView.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 28/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

protocol WeightSliderViewDelegate
{
    func setWeight(kgWeight : Float)
    func enableScreen()
}

class WeightSliderView: UIView {

    var delegate:WeightSliderViewDelegate?
    
    // MARK: Outlets
    
    var sliderView : UIView!
    var weightSlider : UISlider!
    var mainValueTitle : UILabel!
    var stonesTitle : UILabel!
    var poundsTitle : UILabel!
    
    func buildView (maxWeightValue : Int) {

        self.frame =  CGRect(x: 0 , y: self.frame.origin.y , width: self.frame.width, height: self.frame.height)

        var xPos = 0
        var yPos = 0
        
        self.backgroundColor = GlobalConstants.weightAndHeightSliderColour
        
        /** Main Value */
 
        let titleWidth = 80
        
        let mainValueTitleXPos = (Int(self.frame.width) / 2) - (titleWidth/2)
        
        mainValueTitle = UILabel(frame: CGRect(x: mainValueTitleXPos, y: yPos , width: titleWidth, height: 30))
        mainValueTitle.text = "0 kg"
        mainValueTitle.textAlignment = NSTextAlignment.center
        mainValueTitle.font = UIFont.boldSystemFont(ofSize: mainValueTitle.font.pointSize)
        self.addSubview(mainValueTitle)

        // Left hand side
        stonesTitle = UILabel(frame: CGRect(x: 10, y: yPos , width: titleWidth, height: 30))
        stonesTitle.text = "0 st"
        stonesTitle.textAlignment = NSTextAlignment.center
        stonesTitle.font = stonesTitle.font.withSize(12)
        self.addSubview(stonesTitle )

        // Right hand side
        poundsTitle = UILabel(frame: CGRect(x: mainValueTitleXPos + 120, y: yPos , width: titleWidth, height: 30))
        poundsTitle.text = "0 lb"
        poundsTitle.textAlignment = NSTextAlignment.center
        poundsTitle.font = poundsTitle.font.withSize(12)
        self.addSubview(poundsTitle )
       
        yPos = Int(mainValueTitle.frame.size.height + 5)
        let sliderWidth = Int(self.frame.size.width-50)
        xPos = Int((Int(self.frame.size.width) - sliderWidth) / 2)

        buildScale(sliderWidth: sliderWidth, xPos: xPos, yPos: yPos, maxValue: maxWeightValue)
        
        yPos = yPos + 27
        
        /** Slider */
        
        weightSlider = UISlider(frame: CGRect(x: xPos, y: yPos , width: sliderWidth, height: 25))
        weightSlider.minimumValue = 0
        weightSlider.maximumValue = Float(maxWeightValue)
        weightSlider.isContinuous = true; // false makes it call only once you let go
        weightSlider.addTarget(self, action: #selector(sliderValueChanged), for: UIControlEvents.valueChanged)

        self.addSubview(weightSlider)

        /** - symbol at the beginning of slider */
        let minusSymbol = UIImageView(frame: CGRect(x: xPos - 20, y: yPos+5 , width: 15, height: 15))
        let minusImage = UIImage(named: "minus-icon")
        minusSymbol.image = minusImage

        // TODO:  Tap gesture to up the slider value by 1
        self.addSubview(minusSymbol)
        
        /** + symbol at the end of slider */
        let plusSymbol =  UIImageView(frame: CGRect(x: xPos + sliderWidth + 5, y: yPos+5 , width: 15, height: 15))
        let plusImage = UIImage(named: "plus-icon")
        plusSymbol.image = plusImage

        // TODO:  Tap gesture to up the slider value by 1
        self.addSubview(plusSymbol)
        
        yPos = yPos + Int(weightSlider.frame.height) + 15
        
        
        /** Ok button */
        
        let okBtnWidth = 70
        let okBtnXPos = 20
        let okBtn: UIButton = UIButton(frame: CGRect(x: okBtnXPos, y: yPos , width: okBtnWidth, height: 25))
        okBtn.backgroundColor = UIColor.gray
        okBtn.setTitle("Ok", for: .normal)
        okBtn.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        okBtn.layer.cornerRadius = 5
        
        self.addSubview(okBtn)
        
        /** Cancel button */
        
        let cancelBtnWidth = 70
        let cancelBtnXPos = Int(self.frame.width) - cancelBtnWidth - 20
        let cancelBtn: UIButton = UIButton(frame: CGRect(x: cancelBtnXPos, y: yPos , width: cancelBtnWidth, height: 25))
        cancelBtn.backgroundColor = UIColor.gray
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelBtn.layer.cornerRadius = 5
        
        self.addSubview(cancelBtn)

        yPos = yPos + Int(okBtn.frame.height) + 10
        
        // Resize view
        self.frame =  CGRect(x: self.frame.origin.x , y: self.frame.origin.y , width: self.frame.width, height: CGFloat(yPos))
        
    }

    func buildScale(sliderWidth : Int, xPos : Int, yPos : Int, maxValue : Int) {
        
        let strideValue = sliderWidth / 20
        var lastXPos = 0
        
        let firstScaleMark = UILabel(frame: CGRect(x: lastXPos+10, y: yPos , width: 10, height: 10 ))
        firstScaleMark.text = "0"
        firstScaleMark.sizeToFit()
        firstScaleMark.textColor = UIColor.lightGray
        
        self.addSubview(firstScaleMark)

        for i in stride(from: 0, to: sliderWidth, by: strideValue) {
            let xPos = xPos + i
            let scaleMark = UILabel(frame: CGRect(x: xPos, y: yPos , width: 10, height: 10 ))

            scaleMark.text = "."
            scaleMark.textAlignment = .center
            scaleMark.sizeToFit()
            scaleMark.textColor = UIColor.lightGray
            self.addSubview(scaleMark)
            
            lastXPos = xPos
        }
        
        let lastScaleMark = UILabel(frame: CGRect(x: lastXPos+10, y: yPos , width: 10, height: 10 ))
        lastScaleMark.text = String(maxValue)
        lastScaleMark.sizeToFit()
        lastScaleMark.textColor = UIColor.lightGray
        self.addSubview(lastScaleMark)
    }
    
    func sliderValueChanged(sender: UISlider) {
        // round the slider position to the nearest index of the numbers array
        let sliderWeightValue = (Float)(weightSlider!.value);

        let conv = Conversions()
        
        //mainValueTitle.text = String(sliderWeightValue) + " kg"
        mainValueTitle.text =  String(format: "%.2f", sliderWeightValue) + " kg"
        
//        poundsTitle.text = conv.kgToPounds(kgWeight: sliderWeightValue) + " lb"

        let poundsAndOunces = conv.kgToPounds(kgWeight: sliderWeightValue)
        let pounds1 = floor(Double(poundsAndOunces)!)
        let ouncesFraction = Double(poundsAndOunces)?.truncatingRemainder(dividingBy: 1)
        let ounces = floor(ouncesFraction! * 16)
        
        poundsTitle.text = String(Int(pounds1)) + " lb " + String(Int(ounces)) + " oz"
       
        
        let stonesAndPounds = conv.kgToStones(kgWeight: sliderWeightValue)
        
        let stones = floor(Double(stonesAndPounds)!)
        let poundsFraction = Double(stonesAndPounds)?.truncatingRemainder(dividingBy: 1)

        let pounds = floor(poundsFraction! * 14)
        stonesTitle.text = String(Int(stones)) + " st " + String(Int(pounds)) + " lb"
    }
    
    // MARK:  Button Methods
    @IBAction func okButtonPressed(_ sender: AnyObject) {
        
        delegate?.setWeight(kgWeight:Float(weightSlider!.value))
        delegate?.enableScreen()
        
        // Dismiss view
        self.removeFromSuperview()
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        
        delegate?.enableScreen()
        
        // Dismiss view
        self.removeFromSuperview()
    }
    
}
