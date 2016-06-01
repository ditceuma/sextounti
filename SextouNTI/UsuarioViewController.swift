//
//  UsuarioViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 17/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class UsuarioViewController: UIViewController {


    @IBOutlet weak var imagemUsuario: UIImageView!
    
    @IBOutlet weak var nomeUsuarioLabel: UILabel!
    
    @IBOutlet weak var emailUsuarioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagemUsuario.image = usuarioLogin.imagem
        self.nomeUsuarioLabel!.text = usuarioLogin.nome
        self.emailUsuarioLabel!.text = usuarioLogin.email
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
