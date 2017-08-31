//
//  DatePicker.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 30/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

protocol DatePickerDelegate
{
    func setDate(selectedDate : NSDate)
    func enableScreen()
}

class DatePicker: UIView {

    var delegate:DatePickerDelegate?
    
    // MARK: Outlets
    
    var datePicker = UIDatePicker()
    
    func buildPicker() {
                
        let pickerHeight = CGFloat(200)
        self.backgroundColor = GlobalConstants.datePickerColour
        
        /** Toolbar for Done and Cancel buttons */
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0 , width: self.frame.width, height: 30))
        self.addSubview(toolbar)
        toolbar.sizeToFit()
        toolbar.barTintColor = GlobalConstants.datePickerToolbarColour

        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DatePicker.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DatePicker.cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        var yPos = toolbar.frame.size.height + 10
        
        /** Date Picker */
        
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: yPos , width: self.frame.width, height: pickerHeight))
        self.addSubview(datePicker)
        
        yPos = yPos + datePicker.frame.size.height
        
        // Resize view
        self.frame =  CGRect(x: self.frame.origin.x , y: self.frame.origin.y , width: self.frame.width, height: CGFloat(yPos))
        
        //show date picker
        showDatePicker()
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
    }
    
    func donedatePicker(){
       
        delegate?.setDate(selectedDate: datePicker.date as NSDate)
        delegate?.enableScreen()
        // Dismiss view
        self.removeFromSuperview()

    }
    
    func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        //self.view.endEditing(true)
        // Dismiss view
        delegate?.enableScreen()
        self.removeFromSuperview()

    }
    
/*
    var dateLabel : UILabel!
    var datePicker : UIDatePicker!

    func buildPicker() {

        let pickerHeight = CGFloat(200)
        
        self.backgroundColor = GlobalConstants.weightAndHeightSliderColour
        
        self.frame =  CGRect(x: 0 , y: self.frame.origin.y , width: self.frame.width, height: self.frame.height)

        dateLabel = UILabel(frame: CGRect(x: 0, y: 0 , width: self.frame.width, height: 30))
        self.addSubview(dateLabel)

        var yPos = dateLabel.frame.size.height + 10

        datePicker = UIDatePicker(frame: CGRect(x: 0, y: yPos , width: self.frame.width, height: pickerHeight))
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: UIControlEvents.valueChanged)

        self.addSubview(datePicker)

        yPos = yPos + datePicker.frame.size.height
        
        // Resize view
        self.frame =  CGRect(x: self.frame.origin.x , y: self.frame.origin.y , width: self.frame.width, height: CGFloat(yPos))
        
    }
    
    func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateLabel.text = strDate
    }
*/
}
