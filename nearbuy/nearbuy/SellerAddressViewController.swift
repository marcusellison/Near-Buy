//
//  SellerAddressViewController.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/18/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class SellerAddressViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    let gpaViewController = GooglePlacesAutocomplete(
        apiKey: "AIzaSyDYDEWYu34-J1RJbSv6E4m2521hiJ_HCKA",
        placeType: .Address
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gpaViewController.placeDelegate = self // Conforms to GooglePlacesAutocompleteDelegate
        
        presentViewController(gpaViewController, animated: true, completion: nil)
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
        
        //save to parse here
        
        returnToBrowse(sender)
    }
    
    @IBAction func onChangeAddress(sender: AnyObject) {
        
        self.loadSearchView()
        
    }

}

extension SellerAddressViewController: GooglePlacesAutocompleteDelegate {

    func placeSelected(place: Place) {
        
        //update address
        addressLabel.text = place.description
        
        // break out address into street, streetName, city, state, zip
//        place.getDetails { details in
//            println("StreetNumber: \(details.streetNumber)")
//            println("StreetName: \(details.streetName)")
//            println("City: \(details.cityName)")
//            println("State: \(details.stateName)")
//            println("Zip: \(details.zip)")
//            
//        }
        
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
}
