//
//  SettingsCell.swift
//  FacebookDemoSwift
//
//  Created by Jim Cai on 4/16/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
