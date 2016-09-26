//
//  UsuarioViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 17/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FirebaseAuth
import FirebaseStorage

var usuarioLogin:UsuarioSocial = UsuarioSocial()!

class UsuarioViewController: UIViewController {
    
    @IBOutlet weak var uilName: UILabel!
    @IBOutlet weak var uiimvProfilePic: UIImageView!
    @IBOutlet weak var uilEmail: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiimvProfilePic.layer.cornerRadius = self.uiimvProfilePic.frame.size.height/2
        self.uiimvProfilePic.layer.masksToBounds = false
        self.uiimvProfilePic.clipsToBounds = true
        
        self.uiimvProfilePic.layer.borderWidth = 2.0;
        self.uiimvProfilePic.layer.borderColor = UIColor.whiteColor().CGColor
        
        btnLogout.backgroundColor = UIColor.clearColor()
        btnLogout.layer.borderWidth = 1.0
        btnLogout.layer.borderColor = UIColor.whiteColor().CGColor
        
        if let user = FIRAuth.auth()?.currentUser {
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid;
            
            self.uilName.text = name
            self.uilEmail.text = email
            
            
            // Get a reference to the storage service, using the default Firebase App
            let storage = FIRStorage.storage()
            
            // Create a storage reference from our storage service
            let storageRef = storage.referenceForURL("gs://sextou-nti.appspot.com")
            
            // Create a reference to the file you want to upload
            let profilePicRef = storageRef.child(uid + "/profile_pic.jpg")

            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            profilePicRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
                
                if (error != nil) {
                    print("Unable to download image")
                } else {
                    // Data for "images/island.jpg" is returned
                    self.uiimvProfilePic.image = UIImage(data: data!)
                }
            }
                        
            
        } else {
            // No user is signed in.
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func logoutUser(sender: AnyObject) {
        
        // signs the user out of the firebase  app
        try! FIRAuth.auth()!.signOut()
        
        FBSDKAccessToken.setCurrentAccessToken(nil)
        
        // move the user to the Login Screen
        let mainStoreBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let LoginViewController  = mainStoreBoard.instantiateViewControllerWithIdentifier("LoginViewController")
        
        self.presentViewController(LoginViewController, animated: true, completion: nil)
        
    }

}
