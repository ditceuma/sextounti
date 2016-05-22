 //
//  LoginViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextViewDelegate, NSURLConnectionDelegate,UITextFieldDelegate {
    
    // MARK: Properties

    @IBOutlet weak var emailTexField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTexField.delegate = self
        senhaTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        NSLog("Teste:   \(object.allValues.last?.description)")
        NSLog("Teste 2: \(object.allKeys.description)")
        NSLog("Teste 3: \(object.allKeys.description.containsString("codigo"))")
        
        NSLog("Teste 4: \(object.objectForKey("codigo"))")
        // Verifica se o serviço retornou uma mensagem de erro, já padronizada com código 13
        
        if(object.objectForKey("codigo")!.isEqual("13")) {
            
          Alerta.alerta("Usuario/Senha inválidos!", viewController: self)
           // UserNameLabel.text = "Usuario/Senha inválidos!"
            return
            
        }else{
        
        
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
            
            self.performSegueWithIdentifier("segueForTrilha", sender: self)
        }
        
    }

    
    // MARK: Actions
    
    @IBAction func loginUsuario(sender: UIButton) {
        
        let md5 = MD5()
        let usuario = Usuario()
        
        if(emailTexField.text!.isEmpty || senhaTextField.text!.isEmpty){
            Alerta.alerta("Preencha os campos!", viewController: self)
        }else{
            
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
                        
                            
                                self.CarregaUsuario(object)
                            
                        } catch let jsonError as NSError {
                            print( "JSONError: \( jsonError.localizedDescription )")
                        }
                    }
                }
                task.resume()
            }
        }

    }
    

}

