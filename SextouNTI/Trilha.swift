//
//  Trilha.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//
import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Trilha {
    public var codigo : Int?
    public var usuario : Usuario?
    public var titulo : String?
    public var sobre : String?
    public var dataFormatada: String?
    public var likes: Int?
    public var comentarios: Int?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let trilha_list = Trilha.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Trilha Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Trilha]
    {
        var models:[Trilha] = []
        for item in array
        {
            models.append(Trilha(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let trilha = Trilha(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Trilha Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        codigo = dictionary["codigo"] as? Int
        if (dictionary["usuario"] != nil) { usuario = Usuario(dictionary: dictionary["usuario"] as! NSDictionary) }
        titulo = dictionary["titulo"] as? String
        sobre = dictionary["sobre"] as? String
        dataFormatada = dictionary["dataFormatada"] as? String
        likes = dictionary["likes"] as? Int
        comentarios = dictionary["comentarios"] as? Int
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
        dictionary.setValue(self.usuario, forKey: "usuario")
        dictionary.setValue(self.titulo, forKey: "titulo")
        dictionary.setValue(self.sobre, forKey: "sobre")
        dictionary.setValue(self.likes, forKey: "likes")
        dictionary.setValue(self.comentarios, forKey: "comentarios")
        
        return dictionary
    }
    

    
}
