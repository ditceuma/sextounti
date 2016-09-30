//
//  Usuario.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Usuario {
    public var codigo : Int?
    public var matricula : Int?
    public var nome : String?
    public var email : String?
    public var senha : String?
    public var perfil : Perfil?
    public var urlImage : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let usuario_list = Usuario.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Usuario Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Usuario]
    {
        var models:[Usuario] = []
        for item in array
        {
            models.append(Usuario(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let usuario = Usuario(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Usuario Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        codigo = dictionary["codigo"] as? Int
        matricula = dictionary["matricula"] as? Int
        nome = dictionary["nome"] as? String
        email = dictionary["email"] as? String
        senha = dictionary["senha"] as? String
        urlImage = dictionary["urlImage"] as? String
        if (dictionary["perfil"] != nil) { perfil = Perfil(dictionary: dictionary["perfil"] as! NSDictionary) }
    }
    
    required public init?() {
        
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.codigo, forKey: "codigo")
        dictionary.setValue(self.matricula, forKey: "matricula")
        dictionary.setValue(self.nome, forKey: "nome")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.senha, forKey: "senha")
        dictionary.setValue(self.urlImage, forKey: "urlImage")
        dictionary.setValue(self.perfil?.dictionaryRepresentation(), forKey: "perfil")
        
        return dictionary
    }
    

    
}
