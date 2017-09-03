//
//  HeightReviewListCell.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 02/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class HeightReviewListCell: UITableViewCell {

    @IBOutlet weak var heightValue : UILabel!
    @IBOutlet weak var dateMeasured : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
