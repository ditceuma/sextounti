//
//  LoginIterator.swift
//  SextouNTI
//
//  Created by Michel Cordeiro on 20/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import Foundation


class LoginInteractor {
   
    
    func preparaLogin(usuario: Usuario) {
        
        let md5 = MD5()
        let usuario = Usuario()
        
        usuario.senha = md5.digest(string: usuario.senha)
        
        let http = NSURLSession.sharedSession()
        
        let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/login?token=99678f8f11be783c5e33c11008ba6772&email=" + usuario.email + "&password=" + usuario.senha)!
        
        NSLog("url de conexão: \(url)")
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            let task = http.dataTaskWithURL(url) {(data, response, error ) -> Void in
                
                if(error != nil) {
                    
                    print("URL Error!!")
                } else {
                    do {
                        let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        
                        
                        
                        
                    } catch let jsonError as NSError {
                        print( "JSONError: \( jsonError.localizedDescription )")
                    }
                }
            }
            task.resume()
        }
    }
    
    



}