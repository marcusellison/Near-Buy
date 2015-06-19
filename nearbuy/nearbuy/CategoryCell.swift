//
//  CategoryCell.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/18/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate {
  func userTapped(category: String)
}

class CategoryCell: UITableViewCell {
    /*
    var delegate = CategoryCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.userInteractionEnabled = true

        self.addGestureRecognizer(tapRecognizer)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func userTapped(){
        println("Image tapped")
        
        if let delegate = delegate {
            delegate.userTapped(tweet!.user!)
        }
        
    }

*/

}
