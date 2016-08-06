//
//  UsuarioViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 17/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class UsuarioViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var imagemUsuario: UIImageView!
    
    @IBOutlet weak var nomeUsuarioLabel: UILabel!
    
    @IBOutlet weak var emailUsuarioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let utilImagem = UtilImagem()
        
        self.imagemUsuario.image = utilImagem.achaImagemPorMatricula(String(usuarioLogin!.matricula!))
        self.nomeUsuarioLabel!.text = usuarioLogin!.nome
        self.emailUsuarioLabel!.text = usuarioLogin!.email
        

    }

    // MARK: Actions

    @IBAction func logout(sender: AnyObject) {
        
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.presentViewController(VC1, animated:true, completion: nil)
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
