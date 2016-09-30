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
import FirebaseStorage
import FirebaseDatabase

 


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
                let name = user.displayName
                let email = user.email
                let photoUrl = user.photoURL
                let uid = user.uid;
                
                usuarioLogin.uid = uid
                usuarioLogin.nome = name
                usuarioLogin.email = email
                usuarioLogin.urlImage = photoUrl?.absoluteString
                
                // move the user to the home screen
                let mainStoreBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let tabBarController  = mainStoreBoard.instantiateViewControllerWithIdentifier("TabBarController")
                
                self.presentViewController(tabBarController, animated: true, completion: nil)
                
            } else {
                
                self.loginButton.center = CGPointMake(self.view.center.x, self.view.frame.height - 100)
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
                
                self.gravaUsuario()
                
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User did Logout")
    }
    

    
    func CarregaUsuario(object: NSDictionary) {
        
      
        // Verifica se o serviço retornou uma mensagem de erro, já padronizada com código 13
        
        if(object.objectForKey("codigo")!.isEqual("13")) {
            
            return
            
        }else{
    
            usuarioLogin = UsuarioSocial(dictionary: object)!

            self.performSegueWithIdentifier("segueForTrilhas", sender: self)

        
        }
        
    }
    
    func gravaUsuario() {
        
        if let user = FIRAuth.auth()?.currentUser {
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid;
            
            var imagemPerfil: UIImage?
            
            usuarioLogin.uid = uid
            usuarioLogin.nome = name
            usuarioLogin.email = email
            usuarioLogin.urlImage = photoUrl?.absoluteString
            
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
                    imagemPerfil = UIImage(data: data!)!
                }
            }
            
            if imagemPerfil == nil {
                
                let profilePic = FBSDKGraphRequest(graphPath: "me/picture", parameters: ["height":300, "width":"300", "redirect":false], HTTPMethod: "GET")
                
                profilePic.startWithCompletionHandler({(connection, result, error) -> Void in
                    
                    if (error == nil) {
                        
                        let dictionary = result as? NSDictionary
                        let data = dictionary?.objectForKey("data")
                        
                        let urlPic = (data?.objectForKey("url"))! as! String
                        if let imageData = NSData(contentsOfURL: NSURL(string: urlPic)!) {
                            
                            
                            // Upload the file to the path "images/rivers.jpg"
                            _ = profilePicRef.putData(imageData, metadata: nil) { metadata, error in
                                
                                if (error == nil) {
                                    // Metadata contains file metadata such as size, content-type, and download URL.
                                    let downloadURL = metadata!.downloadURL()
                                    
                                    usuarioLogin.urlImage = downloadURL!.absoluteString
                                    
                                    let dataBaseRef = FIRDatabase.database().reference()
                                    
                                    let userDic = usuarioLogin.dictionaryRepresentation()
                                    
                                    dataBaseRef.child("usuario_social").child(usuarioLogin.uid!).setValue(userDic)

                                    let changeRequest = user.profileChangeRequest()
                                    
                                    changeRequest.photoURL = downloadURL
                                    changeRequest.commitChangesWithCompletion { error in
                                        if error != nil {
                                            print("unable to update photoURL!")
                                        } else {
                                            print("photo updated!")
                                        }
                                    }

                                    
                                } else {
                                    print("Error in downloadImage")
                                }
                            }
                            
                            imagemPerfil = UIImage(data: imageData)
                            
                        }
                        
                    }
                    
                })
            }
            
            
        } else {
            // No user is signed in.
        }
    }
      

}

