//
//  TakePhotosDetailViewController.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class TakePhotosDetailViewController: UIViewController, CategoryPickedDelegate {
    
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productDescriptionField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    
    var productImage : UIImage?
    
    var pickCategoriesViewController: PickCategoriesViewController?
    
    private var product: Product = Product(params: [:])

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // assigns picks categories as delegate
        if segue.identifier == "PickCategories" {
            (segue.destinationViewController as! PickCategoriesViewController).categoryDelegate = self
        }
    }
    
    @IBAction func onSell(sender: AnyObject) {
        
        var image = self.productImage
        
        var params: NSDictionary = ["username":"seller@awesome.com",
            "name":productNameField.text,
            "summary":productDescriptionField.text,
            "price": productPriceField.text,
            "shared":"true",
            "category":categoryField.text,
            "image":image!]
        
        // probably not the best way to test. Generate alert if field is empty
        for (title, fieldValue) in params {
            if "\(fieldValue)" == "" {
                var alert = UIAlertController(title: "Oops!", message: "Please fill out all fields", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        // Let's create a product!
        product.create(params as! [String:AnyObject])
        
    }
    
    // implementing protocol
    func didSelectCategory(category: String) {
        categoryField.text = category
    }

}
