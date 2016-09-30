//
//  TrilhaTableViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 16/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit
import FirebaseDatabase


class TrilhaTableViewController: UITableViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tableViewTrilhas: UITableView!
    
    var trilhasArray: [Trilha] = []
    
    let ref = FIRDatabase.database().reference()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref.observeEventType(.Value, withBlock: { (snapshot) in
            
            //print(snapshot.value)
            self.trilhasArray.removeAll()
            
            self.carregaTrilhas(snapshot.value as! NSDictionary)
            self.tableViewTrilhas.reloadData()
   
        }) { (error) in
            print(error.localizedDescription)
        }
        

    }
    
    
    func carregaTrilhas(snapshot: NSDictionary) {
        
        let fabricaModels = FabricaModels()
        
        let trilhas = snapshot["trilhas"] as! NSArray
        
        
        
        for trilha in trilhas {
            let trilhaLocal = Trilha()
            var likesCount = 0
            var comentariosCount = 0
            
            trilhaLocal?.codigo =  trilha["CODIGO"] as? Int
            trilhaLocal?.titulo =  trilha["TITULO"] as? String
            trilhaLocal?.dataFormatada = trilha["DATA_EVENTO"] as? String
            trilhaLocal?.sobre = trilha["SOBRE"] as? String
            
            // Carrega curtidas
            if let likes = snapshot["likes"] as? NSDictionary {
                
                for (_, like) in likes {
                    
                    if (like.objectForKey("FKTRILHA")! as! NSObject) == trilhaLocal?.codigo {
                        likesCount = likesCount + 1
                    }
                }
                trilhaLocal?.likes = likesCount
                
            } else {
                trilhaLocal?.likes = 0
            }
            
            // Carrega Comentarios
            if let comentarios = snapshot["comentarios"] as? NSDictionary {
                
                for (_, comentario) in comentarios {
                    
                    if (comentario.objectForKey("FKTRILHA")! as! NSObject) == trilhaLocal?.codigo {
                        comentariosCount = comentariosCount + 1
                    }
                }
                trilhaLocal?.comentarios = comentariosCount
                
            } else {
                trilhaLocal?.comentarios = 0
            }

            trilhaLocal?.usuario =  fabricaModels.carregaUsuario(snapshot,  codigo: (trilha["FK_USUARIO"] as? Int)!)      // fabricaModels.retornaUsuarioPorCodigo(trilha["FK_USUARIO"] as! Int)
            
            //print(trilhaLocal)
            
            self.trilhasArray.append(trilhaLocal!)
            
        }
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        

    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trilhasArray.count
        
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TrilhaTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TrilhaTableViewCell
        
        // Fetches the appropriate trilha for the data source layout.
        let trilha = trilhasArray[indexPath.row]
        
        let urlImagem = (trilha.usuario?.urlImage!)!
        
        cell.tituloTrilhaLabel.text = trilha.titulo
        cell.dataTrilhaLabel.text = trilha.dataFormatada
        cell.nomeUsuarioLabel.text = trilha.usuario?.nome
        cell.photoImageView.setUrl(urlImagem )
        
        cell.photoImageView.layer.cornerRadius = cell.photoImageView.frame.size.height/2
        cell.photoImageView.layer.masksToBounds = false
        cell.photoImageView.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
       cell.backgroundColor = cell.contentView.backgroundColor
    }



    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc: DetalheTrilhaViewController =  segue.destinationViewController as! DetalheTrilhaViewController
        
        let path = tableViewTrilhas.indexPathForSelectedRow
        let trilha = trilhasArray[path!.row]
        
        vc.trilha = trilha

        
    }

}
