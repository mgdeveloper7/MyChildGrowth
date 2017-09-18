//
//  AboutVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 18/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var titleBarNavItem: UINavigationItem!
    @IBOutlet weak var outerScreenImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  Button Methods
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }



}
