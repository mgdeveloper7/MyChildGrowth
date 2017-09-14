//
//  UINavigationItem+SetTitle.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 11/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    // https://stackoverflow.com/questions/38626004/add-subtitle-under-the-title-in-navigation-bar-controller-in-xcode
    
    func setTitle(title:String, subtitle:String) {
        
        let one = UILabel()
        one.text = title
        one.font = UIFont.boldSystemFont(ofSize: 17)
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = UIFont.systemFont(ofSize: 12)
        two.textAlignment = .center
        two.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        //      one.sizeToFit()
        //      two.sizeToFit()
        
        self.titleView = stackView
    }
}
