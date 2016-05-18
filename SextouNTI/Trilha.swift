//
//  Trilha.swift
//  SextouNTI
//
//  Created by Rabelo on 02/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class Trilha {
    
    var codigo: Int
    var usuario:  Usuario
    var titulo: String
    var sobre: String
    var data: String
    
    
    init(codigo: Int, usuario: Usuario, titulo: String, sobre: String, data: String) {
        self.codigo = codigo
        self.usuario = usuario
        self.titulo = titulo
        self.sobre = sobre
        self.data = data 
    }
}
