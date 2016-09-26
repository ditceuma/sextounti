//
//  FabricaModels.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 21/09/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FabricaModels {
    

    func carregaUsuario(snapshot: NSDictionary, codigo: Int ) -> Usuario {
        
        let usuarios = snapshot["usuarios"] as! NSArray
        
        let usuarioLocal = Usuario()
        
        for usuario in usuarios {
            
            
            if String(usuario["CODIGO"] as! Int) == String(codigo) {
                usuarioLocal?.codigo = usuario["CODIGO"] as? Int
                usuarioLocal?.nome = usuario["NOME"] as? String
                usuarioLocal?.email = usuario["EMAIL"] as? String
                usuarioLocal?.matricula = usuario["MATRICULA"] as? Int
                usuarioLocal?.urlImage = usuario["IMAGEM"] as? String
                
            }
            
        }
        
        return usuarioLocal!
        
    }
    
    func carregaUsuario_social(snapshot: NSDictionary, uid: String ) -> UsuarioSocial {
        
        let usuarioLocal = UsuarioSocial()

        
        if let usuarios = (snapshot["usuario_social"] as?  NSDictionary) {
        
            
            for (_,usuario) in usuarios {
                
                print(usuario)
                
                if (usuario["uid"] as? String) == uid {
                    usuarioLocal?.uid = usuario["uid"] as? String
                    usuarioLocal?.nome = usuario["nome"] as? String
                    usuarioLocal?.email = usuario["email"] as? String
                    usuarioLocal?.urlImage = usuario["urlImage"] as? String
                    
                }
                
            }
        }
        
        return usuarioLocal!
        
    }

    
    
    
}
