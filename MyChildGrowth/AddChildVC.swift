//
//  AddChildVC.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 24/08/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class AddChildVC: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var outerScreenImageView : UIImageView!
    @IBOutlet weak var dateView : DateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateView.buildView()
        dateView.layer.cornerRadius = 5
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
