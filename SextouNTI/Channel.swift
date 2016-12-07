//
//  Channel.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 15/11/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import Foundation

class Channel {
    var name: String?
    var owner: String?
    
    
    required public init?() {
        
    }
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let channel_list = Channel.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
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
     let channel = Channel(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Channel Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        name = dictionary["name"] as? String
        owner = dictionary["owner"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.owner, forKey: "owner")
        
        return dictionary
    }
}
