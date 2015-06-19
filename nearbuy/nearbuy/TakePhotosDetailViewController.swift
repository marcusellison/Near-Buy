//
//  TakePhotosDetailViewController.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class TakePhotosDetailViewController: UIViewController {
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productDescriptionField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    
    var sampleImage : UIImage?
    
    var productImage : UIImage?
    
    
    // Should this always be implicity unwrapped?
    private var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sampleImage = UIImage(named:"bicycle")!
        
        println("image")
        println(productImage)
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
    @IBAction func onSell(sender: AnyObject) {
        
        println("sell me!")
        
        println("Product name field: \(productNameField.text)")
        println("Product name field: \(productDescriptionField.text)")
        println("Product name field: \(productPriceField.text)")
        
        // need to pull in image and link up
        var image = self.sampleImage;
        println("\(image)")
        
        
        /*
        var params: NSDictionary = ["username":"kvodel@mixpanel.com",
            "name":"testing",
            "description":"testing",
            "price":"100",
            "shared":"true",
            "category":"shoes",
            "image":image]
        */

        // "image": image
        
        // product.create(params)
        
        // load data into model.
        
        
    }

}
