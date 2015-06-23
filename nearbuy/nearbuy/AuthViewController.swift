//
//  AuthViewController.swift
//  nearbuy
//
//  Created by Kavodel Ohiomoba on 6/14/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse

class AuthViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    lazy var user : User = User()

    @IBAction func userDidAuth(sender: UIButton) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Log the User in */
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends", "user_relationships"]
        loginView.delegate = self
        
        /* Check for an existing Token -- we should never get here because Parse should have a current User.  If we do get here, let's not make them sign in again */
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            /* There's already an existing access token -- skip the login flow and redirect */
            
            println("access token exists")
        }
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil) {
            /* Process error - maybe ask the user to try again? */
        }
        else if result.isCancelled {
            /* Not sure what to do here? */
        }
        else {
            /* Populate the User Object with Profile Data */
            self.returnUserData()
            
            /* Segue into the Collection View with Products */
            

        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        user.logUserOut();
    }

    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil) {
                /* Process error */
                println("Error: \(error)")
            }
            else {
                println("\(result)")
                let userName : String = result.valueForKey("name") as! String
                let userEmail : String = result.valueForKey("email") as! String
                let gender : String = result.valueForKey("gender") as! String
                let facebookID : String = result.valueForKey("id") as! String
                /* User Attributes to Save after the Request Returns */
                
                var currentUser = PFUser()
                currentUser["username"] = userName
                currentUser["email"] = userEmail
                currentUser["gender"] = gender
                currentUser["profileURL"] = "http://graph.facebook.com/\(facebookID)/picture?type=large"
                
                self.user.register(currentUser)
                self.user.updateUser(currentUser)
                
                /* Segue into next view */
            }
        })
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
