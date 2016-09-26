//
//  ComentTableViewCell.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 21/07/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class ComentTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var imagem: DownloadImageView!

    @IBOutlet weak var nomeUsuarioLabel: UILabel!
    
    @IBOutlet weak var comentarioLabel: UILabel!
    
    @IBOutlet weak var dataComentLabel: UILabel!
    
}
