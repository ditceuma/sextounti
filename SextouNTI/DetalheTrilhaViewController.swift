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

        self.imagemUsuario.layer.borderWidth = 1
        self.imagemUsuario.layer.borderColor = UIColor.blackColor().CGColor
        self.imagemUsuario.layer.cornerRadius = self.imagemUsuario.frame.size.height/2
        self.imagemUsuario.layer.masksToBounds = false
        self.imagemUsuario.clipsToBounds = true
        
        self.tituloTrilha.text = trilha?.titulo
        self.decricaoTrilha.text = trilha?.sobre
        self.imagemUsuario.setUrl((trilha!.usuarioSocial?.urlImage!)!)
        
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
        
        if let trilhas = snapshotLocal!["trilhas"] as? NSDictionary {
            if let trilha = trilhas.objectForKey((trilha?.codigo!)!) as? NSDictionary {
                if let likes = trilha.objectForKey("likes") as? NSDictionary {
                    print(likes)
                    for like in likes {
                        
                        if (like.0) as? String == usuarioLogin.uid {
                            jaCurtiu = true
                         }
                    }
                }
            }
        }
        
        
        if !jaCurtiu {
            
            if let codigoTrilha = trilha?.codigo {
            
                ref.child("trilhas").child(codigoTrilha).child("likes").child(usuarioLogin.uid!).setValue(true)
                
                trilha?.likes = (trilha?.likes)! + 1
                
            }
            

        }
        else {
            
            if let codigoTrilha = trilha?.codigo {
                
                ref.child("trilhas").child(codigoTrilha).child("likes").child(usuarioLogin.uid!).removeValue()
                
                trilha?.likes = (trilha?.likes)! - 1

            }
            
            
        }
        
        let curtidas = trilha?.likes
        let comentarios = trilha?.comentarios
        
        self.numeroComentariosTrilha.text = "(" + String(curtidas!) + ") curtidas (" + String(comentarios!) + ") comentarios"

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
