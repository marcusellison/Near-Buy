//
//  PurchaseConfirmationViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/23/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class PurchaseConfirmationViewController: UIViewController {
    
    lazy var product: Product = Product(params: [:])
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var redactedCCLabel: UILabel!
    
    var passedProduct: NSObject?
    var passedImage: UIImage?
    var passedRedactedCC: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemImage.image = passedImage
        itemTitle.text = passedProduct?.valueForKey("productName") as? String
        var itemPriceVar = passedProduct?.valueForKey("price") as? String
        itemPrice.text = "$\(itemPriceVar!)"
        redactedCCLabel.text = passedRedactedCC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func completePurchase(sender: AnyObject) {
        // sendPurchaseToParse()
        println("purchased \(itemTitle.text)")
        // product.save(["buyer": "kavodel@mixpanel.com", "price": 100])
        
    }

}
