//
//  AppDelegate.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse

// let's decide on this later
let themeColor = UIColor(red: 0.5, green: 0.41, blue: 0.22, alpha: 1.0)

/* Stripe Key */
let stripeKey = "pk_test_9wwe6T1laHfjJWiiquq04p5b"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
        /* Initialize Parse */
        
        var api : API = API()
        api.initParse()
        var user : User = User()
        var payments: Payments = Payments()
        
        /* Request Photos Now to decrease latency */
        println("App Delegate")
        var products: Product = Product(params: ["username":"kavodel@mixpanel.com"])
        
        /* Init Stripe */
        Stripe.setDefaultPublishableKey(stripeKey)
        
        var paymentsParams: NSDictionary = ["cvc": 479, "number":"4242424242424242", "expMonth": 08, "expYear":2018]
        var amount = "100"
        // payments.chargeUser(paymentsParams, amount: amount)
        
        
        
        
        
        /* Initialize Facebook */
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        /*
        /* User Authentication Flow */
        if (PFUser.currentUser() != nil) {
            /* 
                User is already Authed - Take them to root view controller 
            */
            let userDict = PFUser.currentUser()!
            println("\(userDict)")
            user.fetch()
            println("\(user)")
            
        } else {
            /* Parse Facebook Authentication */
            println("authenticate")
            let navigationController = UINavigationController()
            let authViewController = AuthViewController()
            authViewController.view.backgroundColor = UIColor.whiteColor()
            window?.rootViewController = navigationController
            navigationController.navigationBarHidden = true
            navigationController.pushViewController(authViewController, animated: true)
        }
        */


        /* instantiate storyboards */
        
        let buyStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sellStoryboard = UIStoryboard(name: "TakePhoto", bundle: nil)
        let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        let profileStoryboard = UIStoryboard(name: "ProfileTable", bundle: nil)
      
        /* instantiate VCs within storyboards */
        let buyViewController = buyStoryboard.instantiateViewControllerWithIdentifier("BrowseViewController") as! BrowseViewController
        buyViewController.title = "Nearbuy"
        let sellViewController = sellStoryboard.instantiateViewControllerWithIdentifier("takePhoto") as! TakePhotoViewController
        let profileViewController = profileStoryboard.instantiateViewControllerWithIdentifier("ProfileTableViewController") as! ProfileTableViewController
        let settingsViewController = settingsStoryboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        
        /* instantiate tab bar and nav bar */
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController()
        let buyViewNav = UINavigationController()
        let sellViewNav = UINavigationController()
        let profileViewNav = UINavigationController()
        buyViewNav.pushViewController(buyViewController, animated: true)
        sellViewNav.pushViewController(sellViewController, animated: true)
        profileViewNav.pushViewController(profileViewController, animated: true)
        
        /* configure tab bar and embed in nav bar */
        let tabBarConfig = [buyViewNav, sellViewNav, profileViewNav]
        tabBarController.viewControllers = tabBarConfig
        window?.rootViewController = tabBarController
        
        /* customize tab bar */
        buyViewNav.tabBarItem = UITabBarItem(title: "Buy", image: UIImage(named: "postmates"), tag: 1)
        sellViewNav.tabBarItem = UITabBarItem(title: "Sell", image: UIImage(named: "Shape-1"), tag: 2)
        profileViewNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user"), tag: 3)
        
        /* add search in nav bar*/
        // marcus can you add searchbar here?
        /*
        var leftNavBarButton = UIBarButtonItem(customView: <#UIView#>)
        buyViewNav.navigationItem.leftBarButtonItem = leftNavBarButton
        */
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /* Return Facebook Singleton   */
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }


}

