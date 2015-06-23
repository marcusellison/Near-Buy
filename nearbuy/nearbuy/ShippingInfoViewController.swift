//
//  ShippingInfoViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/20/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class ShippingInfoViewController: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var shippingNameTextfield: UITextField!
    @IBOutlet weak var shippingStreetAddressTextfield: UITextField!
    @IBOutlet weak var shippingCityTextfield: UITextField!
    @IBOutlet weak var shippingStateTextfield: UITextField!
    @IBOutlet weak var shippingZipcodeTextfield: UITextField!
    @IBOutlet weak var shippingPhoneTextfield: UITextField!

    var shippingName: String?
    var shippingStreetAddress: String?
    var shippingCity: String?
    var shippingState: String?
    var shippingZip: String?
    var shippingPhone: String?

    // array
    var userShippingInformation: [String : String]?
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        shippingName = shippingNameTextfield.text
        shippingStreetAddress = shippingStreetAddressTextfield.text
        shippingCity = shippingCityTextfield.text
        shippingState = shippingStateTextfield.text
        shippingZip = shippingZipcodeTextfield.text
        shippingPhone = shippingPhoneTextfield.text
        
        userShippingInformation = ["name": shippingName!, "streetAddress": shippingStreetAddress!, "city": shippingCity!, "state": shippingState!, "zip": shippingZip!, "phone": shippingPhone!]
        println(userShippingInformation!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "shippingToBilling" {
            let billingVC = segue.destinationViewController as! BillingInfoViewController
            billingVC.userShippingInformation = self.userShippingInformation
        }
    }
}
