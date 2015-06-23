//
//  BillingInfoViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/19/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class BillingInfoViewController: UIViewController, CardIOPaymentViewControllerDelegate {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var creditCardTextfield: UITextField!
    @IBOutlet weak var billingStreetAddressTextfield: UITextField!
    @IBOutlet weak var billingCityTextfield: UITextField!
    @IBOutlet weak var billingStateTextfield: UITextField!
    @IBOutlet weak var billingZipcodeTextfield: UITextField!
    @IBOutlet weak var shippingAddressSwitch: UISwitch!
    @IBOutlet weak var expirationTextfield: UITextField!
    @IBOutlet weak var cvvTextfield: UITextField!

    var userShippingInformation: [String : String]?
    
    var creditCardNumber: String?
    var creditCardExpirationMonth: UInt?
    var creditCardExpirationYear: UInt?
    var creditCardCVV: String?
    var billingStreetAddress: String?
    var billingCity: String?
    var billingState: String?
    var billingZip: String?
    
    var userBillingInformation: [String : String]?
    
    
    // let's integrate google address search here
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardIOUtilities.preload()
        billingStreetAddressTextfield.text = userShippingInformation?["streetAddress"]
        billingCityTextfield.text = userShippingInformation?["city"]
        billingStateTextfield.text = userShippingInformation?["state"]
        billingZipcodeTextfield.text = userShippingInformation?["zip"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cardIOTapped(sender: AnyObject) {
        var cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
<<<<<<< HEAD
            creditCardNumber = info.cardNumber
            creditCardExpirationMonth = info.expiryMonth
            creditCardExpirationYear = info.expiryYear
            creditCardCVV = info.cvv
            println(str)
            creditCardTextfield.text = info.redactedCardNumber
            expirationTextfield.text = "\(creditCardExpirationMonth)/\(creditCardExpirationYear)"
            cvvTextfield.text = creditCardCVV
=======
            
            var creditCard = [String: AnyObject]()
            creditCard["number"] = info.cardNumber
            creditCard["expMonth"] = info.expiryMonth
            creditCard["expYear"] = info.expiryYear
            creditCard["cvv"] = info.cvv
            
            /* Add to User Object */
            User.sharedInstance.creditCard = creditCard as? [String: String]
>>>>>>> 7fabd3c5e5a337ec52c8ebda8ce2ec09025e5dfe
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func nextButtonTapped(sender: AnyObject) {
        // do i need to set credit card number here or does it carry down?
        
        if creditCardNumber == nil {
            creditCardNumber = creditCardTextfield.text
        }
        billingStreetAddress = billingStreetAddressTextfield.text
        billingCity = billingCityTextfield.text
        billingState = billingStateTextfield.text
        billingZip = billingZipcodeTextfield.text
        
        userBillingInformation = ["creditCard": creditCardNumber!, "streetAddress": billingStreetAddress!, "city": billingCity!, "state": billingState!, "zip": billingZip!]
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


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
