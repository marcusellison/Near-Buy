//
//  ProfileTableViewCell.swift
//  nearbuy
//
//  Created by Jon Choi on 6/22/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var memberSinceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
