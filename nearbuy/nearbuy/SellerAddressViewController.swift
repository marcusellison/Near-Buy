//
//  SellerAddressViewController.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/18/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class SellerAddressViewController: UIViewController {
    
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

}

extension SellerAddressViewController: GooglePlacesAutocompleteDelegate {

    func placeSelected(place: Place) {
        
        println(place.description)
        
        place.getDetails { details in
            println(details)
        }
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
