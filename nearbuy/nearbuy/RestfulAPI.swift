//
//  RestfulAPI.swift
//  nearbuy
//
//  Created by Kavodel Ohiomoba on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

/*
    Delivery API (PostMates)
    Complete Sell Flow ==> Add Seller Address
    Complete Buy Flow ==> Add Credit Card info to Product + Buyer Info
    Complete Delivery Flow 
    Notifications

    Cache Photos
*/

import UIKit
import Parse

let applicationID = "MXh7k8fs6DYgHe3289YMuEiVXfVT3tfgc39DMqXm"
let clientKey = "0co1OmbuCeuovw5r2YdbiJ7wh9AkczJaMdoLGOF0"

let ProductsDidReturn = "ProductsDidReturn"

class API: NSObject {
    lazy var user: User = User()
    // var product: Product = Product(params: ["username":"kavodel@mixpanel.com"])
    
    /* Init Parse */
    
    func initParse() {
        Parse.enableLocalDatastore()
        Parse.setApplicationId(applicationID, clientKey: clientKey)
    }
    
  
    /* 
        Sell 
    */
    
    func addProduct(productInfo: NSDictionary) -> PFObject {
        var product = PFObject(className: "Product")
        
        /* add Properties */
        product["productName"] = productInfo["name"]
        product["summary"] = productInfo["summary"]
        product["price"] = productInfo["price"]
        product["shared"] = productInfo["shared"]
        product["category"] = productInfo["category"]
        let image: UIImage = productInfo["image"] as! UIImage
        
        /* Add a user field to each product - this will crash in test scenarios if you're not authed */
        // product["user"] = use
        
        let imageData = UIImagePNGRepresentation(image)
        
        
        /* Save actual file */
        var filename = productInfo["name"] as! String
        let file = PFFile(name:filename, data:imageData)
        
        product["image"] = file
        
        product.saveInBackgroundWithBlock { (success:Bool, error: NSError?) -> Void in
            if (success) {
                println("success")
            } else {
                println(error!.description)
            }
        }
        return product
    }
    
    /* 
        Buy 
    */
    
    func buyProduct(object: PFObject) -> Bool {
        /* Should I save this locally?  Delete it?  For now I'll delete but this could change */
        // object.deleteInBackground()
        
        return true
    }
    
    func updateProduct(object: PFObject) {
        object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                /* We're going to need to update products real-time in the App */
                println("success")
            }
        }
    }
    
    func downloadImage(file: PFFile) {
        file.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error != nil {
                var img = UIImage(data:imageData!);
                Product.sharedInstance.productImages?.append(img!)
            }
        }
    }
    
    func queryProducts(params: NSDictionary){
        var products: [PFObject]?
        var images: [UIImage]?
        
        var query = PFQuery(className:"Product")
        /* Check if there's an update -- if not, use the cached photos 
            var cachedPhotos:  [PFObject]?
            Product.sharedInstance.products = cachedPhotos
        */
        
        
        print("here")
        
        query.findObjectsInBackgroundWithBlock {
            (productObjects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let productObjects = productObjects as? [PFObject] {
                    /* Save this on the Parse Local Object */
                    println("\(productObjects)")
                    Product.sharedInstance.products = productObjects
                        
                    /* Do whatever you want here - use a notification to update a specific object */
                    NSNotificationCenter.defaultCenter().postNotificationName(ProductsDidReturn, object: self)
                        
                    }
                } else {
                    println(error?.description)
                }
        }
        /*} else {
            
        }*/
    }
    
    
}
