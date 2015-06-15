//
//  Product.swift
//  nearbuy
//
//  Created by Kavodel Ohiomoba on 6/10/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse

class Product: NSObject {
    
    var products: [PFObject]?
    
    /* Here's where you'll query all products */
    
    
    /* 
        Search
    
    */
    
    func search(searchString: String, params: NSDictionary) -> [PFObject]? {
        var matchedProducts: [PFObject]?
        if let products = products {
            for product in products {
                /*if let productName = product.productName {
                    if productName.rangeOfString(searchString, options: .CaseInsensitiveSearch) != nil {
                        matchedProducts.append(product);
                    }
                } */
            }
        }
        
        return matchedProducts
    
    }
    

    
}
