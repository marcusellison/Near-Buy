//
//  BrowseViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse

class BrowseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var products: [NSObject]?
    var imageArray: [UIImage] = []
    var appendCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        var params: NSDictionary = ["username":"kavodel@mixpanel.com"]
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableView", name: "ProductsDidReturn", object: nil)
        println(products)
        println("did it print?")

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 230

        addRefreshControl()
    }
    
    func reloadTableView(){
        self.products = Product.sharedInstance.products
        tableView.reloadData()
    }

    func addRefreshControl() {
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex:0)

    }
    
    func onRefresh() {
        reloadTableView()
        self.refreshControl.endRefreshing()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        if let products = products {
            var count = products.count
            println("product are products!")
        }
        return count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemTableViewCell", forIndexPath: indexPath) as! ItemTableViewCell
        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        /* Iterate through Prods and load images async */
        
        if let products = products {
            var product = products[indexPath.row]
            cell.productNameLabel.text = product.valueForKey("productName") as? String
            var price = product.valueForKey("price") as? String
            println(price!)
            cell.priceLabel.text = "$\(price!)"
            cell.productDescriptionLabel.text = product.valueForKey("summary") as? String
            let userImageFile = product.valueForKey("image") as? PFFile
            userImageFile!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    println("\(imageData!.length)")
                    cell.itemImageView.image = UIImage(data: imageData!)
                }
            }
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("tapped \(indexPath)")
        var storyboard = UIStoryboard(name: "ItemDetail", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("ItemDetailViewController") as! ItemDetailViewController
        controller.passedProduct = products?[indexPath.row]
        println(products?[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

}
