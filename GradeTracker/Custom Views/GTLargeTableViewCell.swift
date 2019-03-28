//
//  GTLargeTableViewCell.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/27/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class GTLargeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
