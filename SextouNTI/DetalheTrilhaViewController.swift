//
//  DetalheTrilhaViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 03/06/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DetalheTrilhaViewController: UIViewController {
    
    // MARK: Model
    var trilha = Trilha()
    var snapshotLocal: AnyObject?
    
    // Referencia do banco
    let ref = FIRDatabase.database().reference()
    
    // MARK: Properties
    @IBOutlet weak var imagemUsuario: DownloadImageView!
    @IBOutlet weak var tituloTrilha: UILabel!
    @IBOutlet weak var decricaoTrilha: UILabel!
    @IBOutlet weak var numeroComentariosTrilha: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeEventType(.Value, withBlock: { (snapshot) in
            
            self.snapshotLocal = snapshot.value
            
            print(self.snapshotLocal)
            
        }) { (error) in
            print(error.localizedDescription)
        }

        let curtidas: Int
        let comentarios: Int

        self.imagemUsuario.layer.cornerRadius = self.imagemUsuario.frame.size.height/2
        self.imagemUsuario.layer.masksToBounds = false
        self.imagemUsuario.clipsToBounds = true
        
        self.tituloTrilha.text = trilha?.titulo
        self.decricaoTrilha.text = trilha?.sobre
        self.imagemUsuario.setUrl((trilha!.usuario?.urlImage!)!)
        
        curtidas = (trilha?.likes)!
        comentarios = (trilha?.comentarios)!

        
        self.numeroComentariosTrilha.text = "(" + String(curtidas) + ") curtidas (" + String(comentarios) + ") comentarios"


    }
    
    override func viewWillAppear(animated: Bool) {
        let curtidas = (trilha?.likes)!
        let comentarios = (trilha?.comentarios)!
        
        
        self.numeroComentariosTrilha.text = "(" + String(curtidas) + ") curtidas (" + String(comentarios) + ") comentarios"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func likeAction(sender: AnyObject) {
        
        var jaCurtiu: Bool = false
        
        // Vefifica se já curtiu

        //print(snapshotLocal!["likes"])
        
        if let likes = snapshotLocal!["likes"] as? NSDictionary {
            
            for (_, like) in likes {
                
                if (like.objectForKey("FKTRILHA")! as! NSObject) == trilha?.codigo && (like.objectForKey("FKUSUARIO") as! String) == usuarioLogin.uid {
                    jaCurtiu = true
                 }
            }
        }
        
        
        if !jaCurtiu {
            
            let like = Like()
            
            like!.codigoTrilha = trilha?.codigo
            like!.usuarioSocial = usuarioLogin
            
            let likeDic = like?.dictionaryRepresentation()
            
            ref.child("likes").childByAutoId().setValue(likeDic)
            
            trilha?.likes = (trilha?.likes)! + 1
            
            let curtidas = trilha?.likes
            let comentarios = trilha?.comentarios
            
            self.numeroComentariosTrilha.text = "(" + String(curtidas!) + ") curtidas (" + String(comentarios!) + ") comentarios"
        }
        else {
            
            
        }

    }
    
    @IBAction func comentAction(sender: AnyObject) {
    }
    
    @IBAction func sharedAction(sender: AnyObject) {
    }
    


 
     // MARK: - Navigation
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
        if segue.identifier == "segueForComents" {
            let vc: ComentarioViewController =  segue.destinationViewController as! ComentarioViewController
         
            vc.trilha = trilha!
            
        }
 
    }

}
