//
//  InnoculationsTimePeriodCell.swift
//  MyChildGrowth
//
//  Created by Mark Gumbs on 04/09/2017.
//  Copyright © 2017 Mark Gumbs. All rights reserved.
//

import UIKit

class InnoculationsTimePeriodCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var selectedLabel : UILabel!
    @IBOutlet weak var timePeriod : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
