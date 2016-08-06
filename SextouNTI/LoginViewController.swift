 //
//  LoginViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit
 
var usuarioLogin:Usuario?

class LoginViewController: UIViewController, UITextViewDelegate, NSURLConnectionDelegate, UITextFieldDelegate {
    
    // MARK: Properties

    
    @IBOutlet weak var emailTexField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var UserNameLabel: UILabel!
    

    @IBAction  func loginUsuario(sender: UIButton) {
        
        let md5 = MD5()
        let usuario = Usuario()
        
        if Reachability.isConnectedToNetwork() {
           
            if(emailTexField.text!.isEmpty || senhaTextField.text!.isEmpty){
                Alerta.alerta("Preencha os campos!", viewController: self)
            }else{
                
                usuario!.email = emailTexField.text!
                
                let http = NSURLSession.sharedSession()
                
                let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/login?token=99678f8f11be783c5e33c11008ba6772&email=" + usuario!.email! + "&password=" + md5.digest(string: senhaTextField.text!))!
                
                NSLog("url de conexão: \(url)")
                
                let task = http.dataTaskWithURL(url) {(data, response, error ) -> Void in
                    
                    if(error != nil) {
                        
                        Alerta.alerta("Erro ao chamar serviço! ", viewController: self)
                        
                        print("URL Error!!")
                    } else {
                        do {
                            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                            
                            dispatch_sync(dispatch_get_main_queue()) {
                                let utilImagem = UtilImagem()
                                utilImagem.carregaImagens()
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
             Alerta.alerta("Sem conexão com a internet!", viewController: self)
        }
        

        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTexField.delegate = self
        senhaTextField.delegate = self
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
            
          //Alerta.alerta("Usuario/Senha inválidos!", viewController: self)
          UserNameLabel.text = "Usuario/Senha inválidos!"
            return
            
        }else{
    
            usuarioLogin = Usuario(dictionary: object)

            self.performSegueWithIdentifier("segueForTrilhas", sender: self)

        
        }
        
    }
      

}

