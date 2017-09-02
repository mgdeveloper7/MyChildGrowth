//
//  Utilities.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 02/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    static let sharedInstance = Utilities()

    class func getUniqueIdBasedOnDate () -> String {
        
        let now = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss.SSS"
        
        // Add random letters to ensure uniqueness just in case a 2 transactions takes place in the same 1000th of a second
        let randomLetters = String.random(length: 1) + String.random(length: 1)
        let uniqueId = formatter.string(from: now as Date) + randomLetters
        
        return uniqueId
        
/*
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
        
        // Add random letters to ensure uniqueness just in case a 2 transactions takes place in the same 1000th of a second
        NSString *randomLetters = [NSString stringWithFormat:@"%c%c", arc4random_uniform(26) + 'a',  arc4random_uniform(26) + 'a'];
        NSString *uniqueId = [NSString stringWithFormat:@"%@%@", [formatter stringFromDate:now], randomLetters];
        return uniqueId;
 */
    }
}

extension String {
    
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
