//
//  ItemDetailViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var product: NSObject?
    var passedImage: UIImage?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        println("it passed here \(product)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemDetailTableViewCell", forIndexPath: indexPath) as! ItemDetailTableViewCell
        cell.itemTitleLabel.text = product?.valueForKey("productName") as? String
        cell.itemPriceLabel.text = product?.valueForKey("price") as? String
        // valueForKey "description" doesn't work?!
        cell.itemDescriptionLabel.text = product?.valueForKey("category") as? String
//        cell.itemDetailImageView.image = product?.valueForKey("image") as?
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
