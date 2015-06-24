//
//  ShippingInfoViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/20/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class ShippingInfoViewController: UIViewController, UITextFieldDelegate {
    
    lazy var user : User = User()
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var shippingNameTextfield: UITextField!
    @IBOutlet weak var shippingStreetAddressTextfield: UITextField!
    @IBOutlet weak var shippingCityTextfield: UITextField!
    @IBOutlet weak var shippingStateTextfield: UITextField!
    @IBOutlet weak var shippingZipcodeTextfield: UITextField!
    @IBOutlet weak var shippingPhoneTextfield: UITextField!

    var userShippingInformation: [String : String]?
    var userShippingInformationForBillingVC: [String: String]?
    
    var shippingName: String?
    var shippingStreetAddress: String?
    var shippingCity: String?
    var shippingState: String?
    var shippingZip: String?
    var shippingPhone: String?

    // for passing across VCs
    var passedProduct: NSObject?
    var passedImage: UIImage?
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        shippingName = shippingNameTextfield.text
        shippingStreetAddress = shippingStreetAddressTextfield.text
        shippingCity = shippingCityTextfield.text
        shippingState = shippingStateTextfield.text
        shippingZip = shippingZipcodeTextfield.text
        shippingPhone = shippingPhoneTextfield.text
        
        userShippingInformationForBillingVC = ["name": shippingName!, "streetAddress": shippingStreetAddress!, "city": shippingCity!, "state": shippingState!, "zip": shippingZip!, "phone": shippingPhone!]
        
        userShippingInformation = ["name": shippingName!, "streetAddress": shippingStreetAddress! + shippingCity! + shippingState! +  shippingZip!, "phone": shippingPhone!]
        
        /* Add to User Object */
        User.sharedInstance.address = userShippingInformation!["streetAddress"]
        User.sharedInstance.phone = userShippingInformation!["phone"]
        user.save(userShippingInformation!)
        
    }
    
    func connectTextFieldDelegates() {
        self.shippingNameTextfield.delegate = self
        self.shippingStreetAddressTextfield.delegate = self
        self.shippingCityTextfield.delegate = self
        self.shippingStateTextfield.delegate = self
        self.shippingZipcodeTextfield.delegate = self
        self.shippingPhoneTextfield.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardDelegates()
        connectTextFieldDelegates()
        
        // pass in image from previous VC
        itemImageView.image = passedImage
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func addKeyboardDelegates() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 170
    }

    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 170
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "shippingToBilling" {
            let billingVC = segue.destinationViewController as! BillingInfoViewController
            billingVC.userShippingInformation = self.userShippingInformationForBillingVC
            billingVC.passedImage = self.passedImage
            billingVC.passedProduct = self.passedProduct
        }
    }
}
