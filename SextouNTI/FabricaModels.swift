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
    

    func retornaUsuarioPorCodigo(codigo: Int) -> Usuario {
        
        let ref = FIRDatabase.database().reference()
        let usuario = Usuario()

        ref.child("usuarios").child("CODIGO").queryEqualToValue("2").observeEventType(.Value) { (snapshot) in
            print(snapshot.value)
        }
        
        //observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
//            // Get user value
//            let usuarioDict = snapshot.value as! NSDictionary
//            print(usuarioDict)
//            
//            usuario!.codigo = usuarioDict["CODIGO"] as? Int
//            usuario!.email = usuarioDict["EMAIL"] as? String
//            usuario!.urlImage = usuarioDict["IMAGEM"] as? String
//            usuario!.matricula = usuarioDict["MATRICULA"] as? Int
//            usuario!.nome = usuarioDict["NOME"] as? String
//            usuario!.senha = usuarioDict["SENHA"] as? String
//            usuario!.perfil = self.retornaPerfilPorCodigo(usuarioDict["FK_PERFIL"] as! Int)
//
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
        return usuario!

    }
    
    func retornaPerfilPorCodigo(codigo: Int) -> Perfil {
        
        let ref = FIRDatabase.database().reference()
        let perfil = Perfil()
        
        ref.child("perfis").child(String(codigo)).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            // Get user value
            let perfilDic = snapshot.value as! NSDictionary
            print(perfilDic)
            
            perfil!.codigo = perfilDic["CODIGO"] as? Int
            perfil!.descricao = perfilDic["DESCRICAO"] as? String
            perfil!.nome = perfilDic["NOME"] as? String
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return perfil!
        
    }
    
    
    
}
