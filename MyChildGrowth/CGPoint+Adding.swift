//
//  CGPoint+Adding.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 07/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

extension CGPoint {
    
    // Used in LineChart.swift
    func adding(x: CGFloat) -> CGPoint { return CGPoint(x: self.x + x, y: self.y) }
    func adding(y: CGFloat) -> CGPoint { return CGPoint(x: self.x, y: self.y + y) }
}
