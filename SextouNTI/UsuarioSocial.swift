//
//  UsuarioSocial.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 24/09/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import Foundation

public class UsuarioSocial: Usuario {
    
    var uid: String?
    
    
    public override func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.uid, forKey: "uid")
        dictionary.setValue(self.nome, forKey: "nome")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.urlImage, forKey: "urlImage")
        
        return dictionary
    }

    
    
}


