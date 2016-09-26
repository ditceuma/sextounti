

import Foundation

public class Comentario {
    public var codigo : Int?
    public var codigoTrilha : Int?
    public var usuarioSocial : UsuarioSocial?
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
        
        codigo = dictionary["CODIGO"] as? Int
        codigoTrilha = dictionary["FKTRILHA"] as? Int
//        idUsuario = dictionary["idUsuario"] as? String
//        if (dictionary["trilha"] != nil) { trilha = Trilha(dictionary: dictionary["trilha"] as! NSDictionary) }
        if (dictionary["usuarioSocial"] != nil) { usuarioSocial = UsuarioSocial(dictionary: dictionary["usuarioSocial"] as! NSDictionary) }
        descricao = dictionary["DESCRICAO"] as? String
        dataFormatada = dictionary["DATA"] as? String
    }
    
    required public init?() {
        
    }
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.codigo, forKey: "CODIGO")
        dictionary.setValue(self.codigoTrilha, forKey: "FKTRILHA")
//        dictionary.setValue(self.idUsuario, forKey: "idUsuario")

//        dictionary.setValue(self.trilha?.dictionaryRepresentation(), forKey: "trilha")
        dictionary.setValue(self.usuarioSocial!.uid, forKey: "FKUSUARIO")
        dictionary.setValue(self.descricao, forKey: "DESCRICAO")
        dictionary.setValue(self.dataFormatada, forKey: "DATA")
        
        return dictionary
    }
    

    
}