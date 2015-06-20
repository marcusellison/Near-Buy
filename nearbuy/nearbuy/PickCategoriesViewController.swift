//
//  PickCategoriesViewController.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/18/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

protocol CategoryPickedDelegate {
    func didSelectCategory(category: String)
}

class PickCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let categories = ["art", "fashion", "electronics", "home", "sports", "other"]
    
    var categoryDelegate: CategoryPickedDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let category = categories[indexPath.row]
        
        self.categoryDelegate?.didSelectCategory(category)
        
        navigationController?.popViewControllerAnimated(true )
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    } */

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
        
        cell.textLabel?.text = categories[indexPath.row]
        
        return cell
    }

}
