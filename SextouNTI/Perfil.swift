//
//  Perfil.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//


import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Perfil {
    public var codigo : Int?
    public var nome : String?
    public var descricao : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let perfil_list = Perfil.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Perfil Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Perfil]
    {
        var models:[Perfil] = []
        for item in array
        {
            models.append(Perfil(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let perfil = Perfil(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Perfil Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        codigo = dictionary["codigo"] as? Int
        nome = dictionary["nome"] as? String
        descricao = dictionary["descricao"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.codigo, forKey: "codigo")
        dictionary.setValue(self.nome, forKey: "nome")
        dictionary.setValue(self.descricao, forKey: "descricao")
        
        return dictionary
    }
    
}