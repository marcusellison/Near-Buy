//
//  ProfileViewController.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/20/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var trustScoreView: UIImageView!
    
    @IBOutlet weak var firstItemLabel: UILabel!
    @IBOutlet weak var firstItemCost: UILabel!
    
    @IBOutlet weak var secondItemLabel: UILabel!
    @IBOutlet weak var secondItemCost: UILabel!
    
    @IBOutlet weak var creditCardNumberLabel: UILabel!
    
//    let products = [Product]()
//    let user: User
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = 10
        profileImageView.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
