//
//  String+Size.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 07/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

extension String {
    
    // Used in LineChart.swift
    func size(withSystemFontSize pointSize: CGFloat) -> CGSize {
        return (self as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: pointSize)])
    }
}

