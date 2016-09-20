//
//  ComentarioViewController.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 20/07/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

import Alamofire

class ComentarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: Properties

    var comentariosArray: [Comentario] = []
    
    var trilha: Trilha?
    
    
    @IBOutlet weak var tableViewComentarios: UITableView!
    
    @IBOutlet weak var comentarioTexField: UITextField!
    
    
    
    // MARK: Actions
    
    @IBAction func enviaComentarioButton(sender: AnyObject) {
        
        
        //  prepare json data
        let coment = Comentario()
        
        var parametros: [String: AnyObject] = [:]
        
        coment!.trilha = trilha
        coment!.usuario = usuarioLogin
        coment!.descricao = comentarioTexField.text!
        
        let comentDic = coment?.dictionaryRepresentation()

        
        
        do {
            let JSONData = try NSJSONSerialization.dataWithJSONObject(comentDic!, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString = NSString(data: JSONData, encoding: NSUTF8StringEncoding)! as String
            
            parametros = ["token": "99678f8f11be783c5e33c11008ba6772", "comentarioJson": jsonString]
            
        } catch let jsonError as NSError {
           print( "JSONError: \( jsonError.localizedDescription )")
        }
        

        
        Alamofire.request(.POST, "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/addComment?", parameters: parametros).responseJSON {
            result in
            
            if result.response?.statusCode == 200 {
                self.comentariosArray.append(coment!)
                self.tableViewComentarios.reloadData()
                print("Comentario salvo!")
                
            }

        }

        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    override func viewWillAppear(animated: Bool) {
        
        let http = NSURLSession.sharedSession()
        
        let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/searchComments?token=99678f8f11be783c5e33c11008ba6772&trilhaCodigo=" + String(trilha!.codigo!))!
        
        let task = http.dataTaskWithURL(url) {(data, response, error ) -> Void in
            
            if(error != nil) {
                print("URL Error!!")
            } else {
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) // as! NSArray
                    
                    if object.isKindOfClass(NSArray) {
                        dispatch_sync(dispatch_get_main_queue(), {
                            self.comentariosArray = Comentario.modelsFromDictionaryArray(object as! NSArray)
                            print(object)
                            self.tableViewComentarios.reloadData()
                        })
                    }
                    
                } catch let jsonError as NSError {
                    print( "JSONError: \( jsonError.localizedDescription )")
                }
            }
        }
        task.resume()
        
        
        
//        Alamofire.request(.GET, "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/searchComments?token=99678f8f11be783c5e33c11008ba6772&trilhaCodigo=").responseJSON {
//            result in
//            
//            if let object = result.data {
//                if object.isKindOfClass(NSArray) {
//                    dispatch_sync(dispatch_get_main_queue(), {
//                        self.comentariosArray = Comentario.modelsFromDictionaryArray(object as! NSArray)
//                        print(object)
//                        self.tableViewComentarios.reloadData()
//                    })
//                }
//            }
//        }
        
            
            
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
        
        let utilImagem = UtilImagem()
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ComentTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ComentTableViewCell
        
        // Fetches the appropriate trilha for the data source layout.
        let comentario = comentariosArray[indexPath.row]
        
        
        cell.nomeUsuarioLabel.text = comentario.usuario?.nome
        cell.comentarioLabel.text = comentario.descricao
        cell.dataComentLabel.text = comentario.dataFormatada
        cell.imagem.image = utilImagem.achaImagemPorMatricula(String(comentario.usuario!.matricula!))
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor = cell.contentView.backgroundColor
    }


}
