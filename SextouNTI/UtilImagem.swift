//
//  File.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 02/08/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import Foundation
import UIKit


class UtilImagem {
    
    func gravaImagens(imagens: [NSArray]) {
        
        
        NSUserDefaults.standardUserDefaults().setObject(imagens, forKey: "imagens")
        
    }
    
    
    func achaImagemPorMatricula(matricula: String) -> UIImage {
        
        let imagemConvertida:UIImage =  UIImage()
        
        if  NSUserDefaults.standardUserDefaults().objectForKey("imagens") != nil {
            let imagens = NSUserDefaults.standardUserDefaults().objectForKey("imagens") as! [NSDictionary]
            
            for imagem:NSDictionary in imagens {
                
                let imageSring = imagem["imagem"] as! NSArray
                
                let base64String = imageSring[0].stringByReplacingOccurrencesOfString("\n", withString: "")
                
                
                if String(imagem["matricula"]!)  == matricula {
                    
                    if let data = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0)) {
                        if let imagemConvertida = UIImage(data: data) {
                            return imagemConvertida
                        }
                    }
                }
                
            }
            
        }
        
        return imagemConvertida
        
        
    }
    
    
    func carregaImagens() {
        
        let http = NSURLSession.sharedSession()
        
        let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/initialize?token=99678f8f11be783c5e33c11008ba6772")!
        
        let task = http.dataTaskWithURL(url) {(data, response, error ) -> Void in
            
            if(error != nil) {
                print("URL Error!!")
            } else {
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    if object.isKindOfClass(NSArray) {
                        
                        dispatch_sync(dispatch_get_main_queue()) {
                            self.gravaImagens(object as! [NSArray])
                        }
                        
                    }
                } catch let jsonError as NSError {
                    print( "JSONError: \( jsonError.localizedDescription )")
                }
            }
        }
        task.resume()
        
        
    }

}