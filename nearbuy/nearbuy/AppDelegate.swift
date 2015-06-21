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
let stripeKey = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
        /* Initialize Parse */
        
        var api : API = API();
        var user : User = User()
        api.initParse()
        
        /* Init Stripe */
        Stripe.setDefaultPublishableKey(stripeKey)
        
        /* Initialize Facebook */
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        /* User Authentication Flow */
        /*
        if (PFUser.currentUser() != nil) {
            /* User is Authed - Take them to root view controller*/
            println("\(PFUser.currentUser())")
            
            
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
        
        // instantiate storyboards
        
        let buyStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sellStoryboard = UIStoryboard(name: "TakePhoto", bundle: nil)
        let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
      
        // instantiate VCs within storyboards
        let buyViewController = buyStoryboard.instantiateViewControllerWithIdentifier("BrowseViewController") as! BrowseViewController
        let sellViewController = sellStoryboard.instantiateViewControllerWithIdentifier("takePhoto") as! TakePhotoViewController
        let settingsViewController = settingsStoryboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        
        // instantiate tab bar and nav bar
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController()
        let buyViewNav = UINavigationController()
        let sellViewNav = UINavigationController()
        let settingsViewNav = UINavigationController()
        buyViewNav.pushViewController(buyViewController, animated: true)
        sellViewNav.pushViewController(sellViewController, animated: true)
        settingsViewNav.pushViewController(settingsViewController, animated: true)
        
        // configure tab bar and embed in nav bar
        let tabBarConfig = [buyViewNav, sellViewNav, settingsViewNav]
        tabBarController.viewControllers = tabBarConfig
        window?.rootViewController = tabBarController
        
        // customize tab bar
        buyViewNav.tabBarItem = UITabBarItem(title: "Buy", image: nil, tag: 1)
        sellViewNav.tabBarItem = UITabBarItem(title: "Sell", image: nil, tag: 2)
        settingsViewNav.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 3)
        
        
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

