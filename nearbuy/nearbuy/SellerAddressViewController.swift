//
//  SellerAddressViewController.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/18/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class SellerAddressViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var apartmentField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    var user: User = User()
    
    
    let gpaViewController = GooglePlacesAutocomplete(
        apiKey: "AIzaSyDYDEWYu34-J1RJbSv6E4m2521hiJ_HCKA",
        placeType: .Address
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gpaViewController.placeDelegate = self // Conforms to GooglePlacesAutocompleteDelegate
        
        presentViewController(gpaViewController, animated: true, completion: nil)
        
        //dismiss keyboard on tap
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
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
    
    
    @IBAction func onConfirmAddress(sender: AnyObject) {
        
        saveContact(sender)
        
        returnToBrowse(sender)
    }
    
    @IBAction func onChangeAddress(sender: AnyObject) {
        
        self.loadSearchView()
        
    }

}

extension SellerAddressViewController: GooglePlacesAutocompleteDelegate {

    func placeSelected(place: Place) {
        
        // break out address into street, city, state, etc
        place.getDetails { details in
//            println("StreetNumber: \(details.streetNumber)")
//            println("StreetName: \(details.streetName)")
//            println("City: \(details.cityName)")
//            println("State: \(details.stateName)")
//            println("Zip: \(details.zip)")
            
            self.streetField.text = details.streetNumber + " " + details.streetName
            self.cityField.text = details.cityName
            self.stateField.text = details.stateName
            self.zipField.text = details.zip
        }
        self.closeSearchView()
    }
    
    func closeSearchView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func returnToBrowse(sender: AnyObject) {
        // Go to root view
        navigationController?.popToRootViewControllerAnimated(true)
        
        // switch tab
        tabBarController?.selectedIndex = 0
    }
    
    func loadSearchView() {
        presentViewController(gpaViewController, animated: true, completion: nil)
    }
    
    func saveContact(sender: AnyObject) {
        
         var userShippingInformation =
            ["name": self.nameField.text,
            "streetAddress": self.streetField.text,
            "apartmentNumber": apartmentField.text,
            "city": self.cityField.text,
            "state": self.stateField.text,
            "zip": self.zipField.text,
            "phone": self.phoneField.text]
        
        var name = nameField.text
        
        validateInputDictionary(userShippingInformation)
        
        validateName(name)
        
        var params = ["address": userShippingInformation, "name": name]
        
        self.user.save(params as! [String : AnyObject])
    }
    
    func validateInputDictionary(userShippingInformation: NSDictionary) {

        for (title, fieldValue) in userShippingInformation {
            if "\(fieldValue)" == "" {
                triggerAlert()
            }
        }
    }
    
    func validateName(name: String) {
        if name == "" {
            triggerAlert()
        }
    }
    
    func triggerAlert() {
        var alert = UIAlertController(title: "Oops!", message: "Please fill out all fields", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
