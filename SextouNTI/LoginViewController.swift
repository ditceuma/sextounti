 //
//  LoginViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextViewDelegate, NSURLConnectionDelegate {
    
    // MARK: Properties

    @IBOutlet weak var emailTexField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CarregaUsuario(object: NSDictionary) {
        
        
            let usuarioLogin = Usuario()
            
            usuarioLogin.codigo = object["codigo"] as! Int
            usuarioLogin.nome = object["nome"] as! String
            usuarioLogin.email = object["email"] as! String
            usuarioLogin.matricula = object["matricula"] as! Int
            
            /*
             if let perfil = object["perfil"] as? NSDictionary {
             usuarioLogin.perfil.codigo = perfil["codigo"] as! Int
             usuarioLogin.perfil.nome = perfil["nome"] as! String
             usuarioLogin.perfil.descricao = perfil["descricao"] as! String
             
             }
             */
            
            print("Codigo: \(usuarioLogin.codigo)")
            print("Nome: \(usuarioLogin.nome)")
            //print("Perfil: \(usuarioLogin.perfil.nome)")
            //print("Descrição: \(usuarioLogin.perfil.descricao)")
            
            UserNameLabel.text = String(usuarioLogin.codigo) +  " - " + usuarioLogin.nome
        
            //let vc: MainViewController = MainViewController()
            //self.presentViewController(vc, animated: true, completion: nil)
            
            self.performSegueWithIdentifier("segueForTrilhas", sender: self)


        
    }

    
    // MARK: Actions
    
    @IBAction func loginUsuario(sender: UIButton) {
        
        let md5 = MD5()
        let usuario = Usuario()
        
        if emailTexField.text != nil && senhaTextField.text != nil {
            
            usuario.email = emailTexField.text!
            usuario.senha = senhaTextField.text!
            
            usuario.senha = md5.digest(string: usuario.senha)
            
            let http = NSURLSession.sharedSession()
        
            let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/login?token=99678f8f11be783c5e33c11008ba6772&email=" + usuario.email + "&password=" + usuario.senha)!
            
            NSLog("url de conexão: \(url)")
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                let task = http.dataTaskWithURL(url) {(data, response, error ) -> Void in
                    
                    if(error != nil) {
                        
                        Alerta.alerta("Erro ao chamar serviço! ", viewController: self)
                        
                        print("URL Error!!")
                    } else {
                        do {
                            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                            
                        
                            // Verifica se o serviço retornou uma mensagem de erro, já padronizada com código 13
                            if(object.allValues.last?.description == "13"){
                                
                               // Alerta.alerta("Usuario/Senha inválidos! ", viewController: self)
                                self.UserNameLabel.text = "Usuario/Senha inválidos!"
                            }else{
                            
                                self.CarregaUsuario(object)
                            }
                            
                            
                        } catch let jsonError as NSError {
                            print( "JSONError: \( jsonError.localizedDescription )")
                        }
                    }
                }
                task.resume()
            }
        } else {
           // Alerta.alerta("Usuario/Senha inválidos! ", viewController: self)
            UserNameLabel.text = "Usuario/Senha inválidos!"
        }

    }
    

}

