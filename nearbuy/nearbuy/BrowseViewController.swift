//
//  BrowseViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        var params: NSDictionary = ["username":"kavodel@mixpanel.com"]
        var prod = Product(params: params)
        prod.get(params)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "specialFunction", name: "ProductsDidReturn", object: nil)
    }
    
    func specialFunction(){
        var products = Product.sharedInstance.products
        println("\(products)")
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCollectionViewCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("tapped \(indexPath)")
        segueToItemDetailViewController()
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
        var storyboard = UIStoryboard(name: "ItemDetail", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("ItemDetailViewController") as! ItemDetailViewController
//        var navController = UINavigationController(rootViewController: controller)
//        navController.pushViewController(controller, animated: true)
//        let button = UIBarButtonItem(
//        navController.navigationItem.leftBarButtonItem = button
        println("is this working")
//        self.presentViewController(navController, animated: true, completion: nil)
        self.navigationController!.pushViewController(controller, animated: true)
        
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
