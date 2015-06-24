//
//  BillingInfoViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/19/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class BillingInfoViewController: UIViewController, CardIOPaymentViewControllerDelegate, UITextFieldDelegate {

    var user: User = User()
    
    // link up labels
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var creditCardTextfield: UITextField!
    @IBOutlet weak var billingStreetAddressTextfield: UITextField!
    @IBOutlet weak var billingCityTextfield: UITextField!
    @IBOutlet weak var billingStateTextfield: UITextField!
    @IBOutlet weak var billingZipcodeTextfield: UITextField!
    @IBOutlet weak var shippingAddressSwitch: UISwitch!
    @IBOutlet weak var expirationTextfield: UITextField!
    @IBOutlet weak var cvvTextfield: UITextField!

    // pass this in
    var userShippingInformation: [String : String]?
    
    // set up variables to load into billing info dict
    var userBillingInformation: [String : AnyObject]?
    var creditCardNumber: String?
    var creditCardExpirationMonth: UInt?
    var creditCardExpirationYear: UInt?
    var creditCardCVV: String?
    var creditCardRedacted: String?
    var billingStreetAddress: String?
    var billingCity: String?
    var billingState: String?
    var billingZip: String?

    var passedProduct: NSObject?
    var passedImage: UIImage?
    
    // let's integrate google address search here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up
        CardIOUtilities.preload()
        connectTextFieldDelegates()
        keyboardNotifications()
        
        // from previous VC
        itemImageView.image = passedImage
        
        // set up the same address
        billingStreetAddressTextfield.text = userShippingInformation?["streetAddress"]
        billingCityTextfield.text = userShippingInformation?["city"]
        billingStateTextfield.text = userShippingInformation?["state"]
        billingZipcodeTextfield.text = userShippingInformation?["zip"]
        
    }
    
    // card info 
    @IBAction func cardIOTapped(sender: AnyObject) {
        var cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        var creditCard = [String: AnyObject]()

        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            User.sharedInstance.creditCard = info.cardNumber
            User.sharedInstance.expMonth = info.expiryMonth
            User.sharedInstance.expYear = info.expiryYear
            User.sharedInstance.cvv = info.cvv
            creditCard["redacted"] = info.redactedCardNumber
            creditCardRedacted = info.redactedCardNumber
            
            /* Add to User Object */
            
        }
        creditCardTextfield.text = creditCard["redacted"] as? String
        var monthInt = creditCard["expMonth"] as? Int
        var yearInt = creditCard["expYear"] as? Int
        var monthString = String(stringInterpolationSegment: monthInt!)
        var yearString = String(stringInterpolationSegment: yearInt!)
        expirationTextfield.text = "\(monthString) / \(yearString)"
        cvvTextfield.text = creditCard["cvv"] as? String
        println(monthString)
        println(yearString)
        println(creditCard)
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    //buttons and switches
    @IBAction func nextButtonTapped(sender: AnyObject) {
        // do i need to set credit card number here or does it carry down?
        
        if creditCardNumber == nil {
            creditCardNumber = creditCardTextfield.text
            var expiration: String = expirationTextfield.text
            var splitExpiration: Array = expiration.componentsSeparatedByString(" ")

            // hard fail...Not gonna be great for demo
            creditCardExpirationMonth = splitExpiration[0].toUInt()
            creditCardExpirationYear = splitExpiration[1].toUInt()
            creditCardCVV = cvvTextfield.text
            
            User.sharedInstance.creditCard = creditCardNumber
            User.sharedInstance.expMonth = creditCardExpirationMonth!
            User.sharedInstance.expYear = creditCardExpirationYear!
            User.sharedInstance.cvv = creditCardCVV
            
            userBillingInformation = ["creditCard":creditCardNumber!,"cvv":creditCardCVV!, "expMonth":creditCardExpirationMonth!, "expYear":creditCardExpirationYear!]
            
            user.save(userBillingInformation!)
        }
        billingStreetAddress = billingStreetAddressTextfield.text
        billingCity = billingCityTextfield.text
        billingState = billingStateTextfield.text
        billingZip = billingZipcodeTextfield.text
        
        
        
        println(userBillingInformation!)
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        if shippingAddressSwitch.on {
            billingStreetAddressTextfield.text = userShippingInformation?["streetAddress"]
            billingCityTextfield.text = userShippingInformation?["city"]
            billingStateTextfield.text = userShippingInformation?["state"]
            billingZipcodeTextfield.text = userShippingInformation?["zip"]
        } else {
            billingStreetAddressTextfield.text = nil
            billingCityTextfield.text = nil
            billingStateTextfield.text = nil
            billingZipcodeTextfield.text = nil
        }
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let confirmVC = segue.destinationViewController as! PurchaseConfirmationViewController
        confirmVC.passedImage = self.passedImage
        confirmVC.passedProduct = self.passedProduct
        confirmVC.passedRedactedCC = self.creditCardTextfield.text
    }

    // keyboard settings
    func keyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func connectTextFieldDelegates() {
        self.creditCardTextfield.delegate = self
        self.billingStreetAddressTextfield.delegate = self
        self.billingCityTextfield.delegate = self
        self.billingStateTextfield.delegate = self
        self.billingZipcodeTextfield.delegate = self
        self.expirationTextfield.delegate = self
        self.cvvTextfield.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 170
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 170
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension String {
    func toUInt() -> UInt? {
        if contains(self, "-") {
            return nil
        }
        return self.withCString { cptr -> UInt? in
            var endPtr : UnsafeMutablePointer<Int8> = nil
            errno = 0
            let result = strtoul(cptr, &endPtr, 10)
            if errno != 0 || endPtr.memory != 0 {
                return nil
            } else {
                return result
            }
        }
    }
}
