//
//  Usuario.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class Usuario {
    
    //testando
    
    let DEFAULT_PASSWORD = "e10adc3949ba59abbe56e057f20f883e"
    
    var codigo: Int = 0
    var email: String = ""
    var matricula: Int = 0
    var nome: String = ""
    var perfil: Perfil!
    var senha: String = ""
    var imagem: UIImage!
    
    
    func  isPasswordDefault() -> Bool {
        return (senha == self.DEFAULT_PASSWORD)
    }
}
