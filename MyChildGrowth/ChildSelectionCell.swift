//
//  ChildSelectionCell.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 15/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class ChildSelectionCell: UITableViewCell {

    @IBOutlet weak var outerView : UIView!
    @IBOutlet weak var childIcon : UIImageView!
    @IBOutlet weak var childNameLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
