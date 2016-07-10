//
//  Trilha.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

var trilhasArray = [Trilha]()

class Trilha {
    
    var codigo: Int = 0
    var nomeUsuario:  String = ""
    var titulo: String = ""
    var sobre: String = ""
    var data: String = ""
    var imagem: UIImage!
    
    
    func carregaTrilhas() {
        
        let http = NSURLSession.sharedSession()
        
        let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/searchTrail?token=99678f8f11be783c5e33c11008ba6772")!
        
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
    
    func exibeTrilhas(trilhas: NSArray) {
        
        trilhasArray.removeAll()
        
        for trilha:AnyObject in trilhas {
            
            let trilhaLocal = Trilha()
            let usuarioTrilha: Usuario = Usuario()
            
            let codigo = trilha["codigo"] as? Int
            let usuario = trilha["usuario"] as? NSDictionary
            let titulo = trilha["titulo"] as? String
            let sobre = trilha["sobre"] as? String
            let data = trilha["dataFormatada"] as? String
            let perfil = usuario!["perfil"] as? NSDictionary
            let nomeUsuario = usuario!["nome"]  as! String
            let matricula = usuario!["matricula"] as! Int
            
            trilhaLocal.codigo = codigo!
            trilhaLocal.titulo = titulo!
            trilhaLocal.sobre = sobre!
            trilhaLocal.data = data!
            trilhaLocal.nomeUsuario = nomeUsuario
            trilhaLocal.imagem = usuarioTrilha.achaImagemPorMatricula( String(matricula))
         
            
            trilhasArray.append(trilhaLocal)
            
            
            print("Codigo: \(trilhaLocal.codigo) ")
            print("Nome: \(trilhaLocal.nomeUsuario)")
            //print("Email: \(trilhaLocal.usuario.email)")
            print("Sobre: \(trilhaLocal.titulo)")
            print("Data: \(trilhaLocal.data)")
        }
        
    }
    
    
}
