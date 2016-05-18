//
//  Comentario.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class Comentario {
    
    // MARK: Properties
    
    var codigo: Int
    var trilha: Trilha
    var usuario: Usuario
    var descricao: String
    var data: NSDate
    
    init(codigo: Int, trilha: Trilha, usuario: Usuario, descricao: String, data: NSDate) {
        self.codigo = codigo
        self.trilha = trilha
        self.usuario = usuario
        self.descricao = descricao
        self.data = data
    }
    
    
}
