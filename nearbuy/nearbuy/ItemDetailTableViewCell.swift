//
//  ItemDetailTableViewCell.swift
//  nearbuy
//
//  Created by Jon Choi on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class ItemDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var itemDetailImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!

    @IBOutlet weak var sellerProfileImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sellerProfileImageView.layer.cornerRadius = self.sellerProfileImageView.layer.frame.size.width / 2
        self.sellerProfileImageView.clipsToBounds = true
        self.sellerProfileImageView.layer.borderWidth = 1.0
        self.sellerProfileImageView.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
