//
//  CompletedPurchaseViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/20/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class CompletedPurchaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToBrowse(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
//        self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        //        self.parentViewController?.navigationController?.popToRootViewControllerAnimated(false)
//        self.dismissViewControllerAnimated(true, completion: nil)
//        self.parentViewController?.navigationController?.popToRootViewControllerAnimated(true)
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let browseVC = mainStoryboard.instantiateViewControllerWithIdentifier("BrowseViewController") as! BrowseViewController
//        let navController = UINavigationController()
//        navController.pushViewController(browseVC, animated: true)
//        presentViewController(navController, animated: true, completion: nil)
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
