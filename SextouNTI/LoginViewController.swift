 //
//  LoginViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

 
var usuarioLogin:Usuario?

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // MARK: Properties

    @IBOutlet weak var aivLoadSpinner: UIActivityIndicatorView!
    
    var loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.loginButton.hidden = true
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                // move the user to the home screen
                let mainStoreBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let tabBarController  = mainStoreBoard.instantiateViewControllerWithIdentifier("TabBarController")
                
                self.presentViewController(tabBarController, animated: true, completion: nil)
                
            } else {
                
                self.loginButton.center = CGPointMake(self.view.center.x, self.view.center.y + 200)
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
                self.loginButton.delegate = self
                
                self.view!.addSubview(self.loginButton)
                
                self.loginButton.hidden = false
                
            }
        }


    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        print("User Logged In")
        
        aivLoadSpinner.startAnimating()
        
        self.loginButton.hidden = true
        
        if (error != nil) {
            self.loginButton.hidden = false
            aivLoadSpinner.stopAnimating()
        }
        else if(result.isCancelled){
            
            self.loginButton.hidden = false
            aivLoadSpinner.stopAnimating()
            
        }
        else {
            
            
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                
                print("User Logged in Firebase")
                
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User did Logout")
    }
    
    // MARK: Tratamento de teclado Libera teclado
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func CarregaUsuario(object: NSDictionary) {
        
      
        // Verifica se o serviço retornou uma mensagem de erro, já padronizada com código 13
        
        if(object.objectForKey("codigo")!.isEqual("13")) {
            
            return
            
        }else{
    
            usuarioLogin = Usuario(dictionary: object)

            self.performSegueWithIdentifier("segueForTrilhas", sender: self)

        
        }
        
    }
      

}

