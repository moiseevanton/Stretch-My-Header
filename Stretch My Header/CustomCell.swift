//
//  CustomCell.swift
//  Stretch My Header
//
//  Created by Anton Moiseev on 2016-06-07.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
