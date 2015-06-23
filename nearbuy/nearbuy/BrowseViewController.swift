//
//  BrowseViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse

class BrowseViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var products: [NSObject]?
    var imageArray: [UIImage] = []
    var appendCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        var params: NSDictionary = ["username":"kavodel@mixpanel.com"]
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadCollectionView", name: "ProductsDidReturn", object: nil)
        println(products)
        println("did it print?")
    }
    
    func reloadCollectionView(){
        self.products = Product.sharedInstance.products
        collectionView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCollectionViewCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        /* Iterate through Prods and load images async */
        
        if let products = products {
            var product = products[indexPath.row]
            let userImageFile = product.valueForKey("image") as? PFFile
            userImageFile!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    println("\(imageData!.length)")
                    cell.itemImageView.image = UIImage(data: imageData!)
                    cell.imageSavedToCell = UIImage(data: imageData!)
//                    self.imageArray.append(cell.itemImageView.image!)
//                    self.appendCount += 1
//                    println(self.appendCount)
                }
            }
            
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 10
        if let products = products {
            var count = products.count
            println("product are products!")
        }
        return count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("tapped \(indexPath)")
        
        var storyboard = UIStoryboard(name: "ItemDetail", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("ItemDetailViewController") as! ItemDetailViewController
        controller.product = products?[indexPath.row]
        println(products?[indexPath.row])
        self.navigationController!.pushViewController(controller, animated: true)
//        segueToItemDetailViewController()
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.1, height: collectionView.frame.size.width/2.1)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let sectionInsets =  UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        return sectionInsets
    }
    
    func segueToItemDetailViewController() {
        println("got to the segue")
//        var storyboard = UIStoryboard(name: "ItemDetail", bundle: nil)
//        var controller = storyboard.instantiateViewControllerWithIdentifier("ItemDetailViewController") as! ItemDetailViewController
//        controller.product = products?[indexPath.row]
//        var navController = UINavigationController(rootViewController: controller)
//        navController.pushViewController(controller, animated: true)
//        let button = UIBarButtonItem(
//        navController.navigationItem.leftBarButtonItem = button
        println("is this working")
//        self.presentViewController(navController, animated: true, completion: nil)
//        self.navigationController!.pushViewController(controller, animated: true)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
