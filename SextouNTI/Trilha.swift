//
//  Trilha.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class Trilha {
    
    var codigo: Int = 0
    var nomeUsuario:  String = ""
    var titulo: String = ""
    var sobre: String = ""
    var data: String = ""
    
    
    func carregaTrilhas() {
        
        let http = NSURLSession.sharedSession()
        
        let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/searchTrail?token=99678f8f11be783c5e33c11008ba6772")!
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            let task = http.dataTaskWithURL(url) {(data, response, error ) -> Void in
                
                if(error != nil) {
                    print("URL Error!!")
                } else {
                    do {
                        let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                        self.exibeTrilhas(object)
                        
                    } catch let jsonError as NSError {
                        print( "JSONError: \( jsonError.localizedDescription )")
                    }
                }
            }
            task.resume()
        }

    }
    
    func exibeTrilhas(trilhas: NSArray) {
        
        print(trilhas)
        
        for trilha:AnyObject in trilhas {
            
            let trilhaLocal = Trilha()
            
            let codigo = trilha["codigo"] as? Int
            let usuario = trilha["usuario"] as? NSDictionary
            let titulo = trilha["titulo"] as? String
            let sobre = trilha["sobre"] as? String
            let data = trilha["dataFormatada"] as? String
            let perfil = usuario!["perfil"] as? NSDictionary
            let nomeUsuario = usuario!["nome"]  as! String
            
            trilhaLocal.codigo = codigo!
            trilhaLocal.titulo = titulo!
            trilhaLocal.sobre = sobre!
            trilhaLocal.data = data!
            trilhaLocal.nomeUsuario = nomeUsuario
            
            /*
             trilhaLocal.usuario.nome = usuario!["nome"] as! String
             trilhaLocal.usuario.email = usuario!["email"] as! String
             trilhaLocal.usuario.matricula = usuario!["matricula"] as! Int
             trilhaLocal.usuario.perfil.codigo = perfil!["codigo"] as! Int
             trilhaLocal.usuario.perfil.descricao = perfil!["descricao"] as! String
             trilhaLocal.usuario.perfil.nome = perfil!["descricao"] as! String
             */
            
            
            trilhasArray.append(trilhaLocal)
            
            
            print("Codigo: \(trilhaLocal.codigo) ")
            print("Nome: \(trilhaLocal.nomeUsuario)")
            //print("Email: \(trilhaLocal.usuario.email)")
            print("Sobre: \(trilhaLocal.titulo)")
            print("Data: \(trilhaLocal.data)")
        }
        
    }
    
    
}
