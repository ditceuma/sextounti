//
//  Like.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 27/09/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import Foundation


public class Like {
    
    var usuarioSocial: UsuarioSocial?
    var curtiu: Bool?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Like = Like(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Like Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Like]
    {
        var models:[Like] = []
        for item in array
        {
            models.append(Like(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let like = Like(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Like Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        //        idUsuario = dictionary["idUsuario"] as? String
        //        if (dictionary["trilha"] != nil) { trilha = Trilha(dictionary: dictionary["trilha"] as! NSDictionary) }
        if (dictionary["usuarioSocial"] != nil) { usuarioSocial = UsuarioSocial(dictionary: dictionary["usuarioSocial"] as! NSDictionary) }
        curtiu = dictionary["curtiu"] as? Bool
    }
    
    required public init?() {
        
    }
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.usuarioSocial!.uid, forKey: "FKUSUARIO")
        dictionary.setValue(self.curtiu, forKey: "curtiu")
        
        return dictionary
    }
    
    
    
    
    
}




