//
//  ComentarioViewController.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 20/07/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

import Alamofire
import FirebaseDatabase

class ComentarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: Properties

    var comentariosArray: [Comentario] = []
    
    var trilha: Trilha?
    
    let ref = FIRDatabase.database().reference()
    
    
    @IBOutlet weak var tableViewComentarios: UITableView!
    
    @IBOutlet weak var comentarioTexField: UITextField!
    
    
    
    // MARK: Actions 
    
    @IBAction func enviaComentarioButton(sender: AnyObject) {
        
        //  prepare json data
        let coment = Comentario()
        
        let dataComentario = NSDate()
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
//        let locale = NSLocale(localeIdentifier: "pt_BR")
//        dateFormatter.locale = locale
        
        coment!.codigoTrilha = trilha?.codigo
        coment!.usuarioSocial = usuarioLogin
        coment!.descricao = comentarioTexField.text!
        coment!.dataFormatada = String(dataComentario)

        
        let comentDic = coment?.dictionaryRepresentation()
        
        self.ref.child("comentarios").childByAutoId().setValue(comentDic)
        
        trilha?.comentarios = (trilha?.comentarios)! + 1

        
    }
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeEventType(.Value, withBlock: { (snapshot) in
            
            //print(snapshot.value)
            self.comentariosArray.removeAll()
            
            self.carregaComentarios(snapshot.value as! NSDictionary)
            self.tableViewComentarios.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        

    }
    
    func carregaComentarios(snapshot: NSDictionary) {
        
        let fabricaModels = FabricaModels()
        
        if let comentarios = (snapshot["comentarios"]  as? NSDictionary)  {
        
            print(comentarios)
        
            for (_, comentario) in comentarios  {
                let comentarioLocal = Comentario()
                
                if (comentario["FKTRILHA"]) != nil {
                    if ((comentario["FKTRILHA"])! as? String) == self.trilha?.codigo {
                        comentarioLocal?.codigo =  comentario["CODIGO"] as? Int
                        comentarioLocal?.descricao =  comentario["DESCRICAO"] as? String
                        comentarioLocal?.dataFormatada =  comentario["DATA"] as? String
                        comentarioLocal?.codigoTrilha =  trilha?.codigo
                        comentarioLocal?.usuarioSocial =  fabricaModels.carregaUsuario_social(snapshot,  uid: (comentario["FKUSUARIO"] as? String)!)      // fabricaModels.retornaUsuarioPorCodigo(trilha["FK_USUARIO"] as! Int)
                        self.comentariosArray.append(comentarioLocal!)
                    }
                }
                
            }
        }
 
    
    }
    


    override func viewWillAppear(animated: Bool) {
        
            
            
    }
    
    // MARK: Tratamento de teclado Libera teclado

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        comentarioTexField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Table view data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comentariosArray.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ComentTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ComentTableViewCell
        
        // Fetches the appropriate trilha for the data source layout.
        let comentario = comentariosArray[indexPath.row]
        
        print(comentario.usuarioSocial!.urlImage!)
        
        cell.nomeUsuarioLabel.text = comentario.usuarioSocial?.nome
        cell.comentarioLabel.text = comentario.descricao
        cell.dataComentLabel.text = comentario.dataFormatada
        cell.imagem.setUrl(comentario.usuarioSocial!.urlImage!)
        
        cell.imagem.layer.cornerRadius = cell.imagem.frame.size.height/2
        cell.imagem.layer.masksToBounds = false
        cell.imagem.clipsToBounds = true

        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor = cell.contentView.backgroundColor
    }


}
