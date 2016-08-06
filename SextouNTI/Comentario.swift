

import Foundation

public class Comentario {
    public var codigo : Int?
    public var trilha : Trilha?
    public var usuario : Usuario?
    public var descricao : String?
    public var dataFormatada : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let Comentario = Comentario.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Comentario Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Comentario]
    {
        var models:[Comentario] = []
        for item in array
        {
            models.append(Comentario(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let Comentario = Comentario(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Comentario Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        codigo = dictionary["codigo"] as? Int
        if (dictionary["trilha"] != nil) { trilha = Trilha(dictionary: dictionary["trilha"] as! NSDictionary) }
        if (dictionary["usuario"] != nil) { usuario = Usuario(dictionary: dictionary["usuario"] as! NSDictionary) }
        descricao = dictionary["descricao"] as? String
        dataFormatada = dictionary["dataFormatada"] as? String
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
        dictionary.setValue(self.trilha?.dictionaryRepresentation(), forKey: "trilha")
        dictionary.setValue(self.usuario?.dictionaryRepresentation(), forKey: "usuario")
        dictionary.setValue(self.descricao, forKey: "descricao")
        dictionary.setValue(self.dataFormatada, forKey: "dataFormatada")
        
        return dictionary
    }
    

    
}