//
//  TrilhaTableViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 16/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class TrilhaTableViewController: UITableViewController {
    
    var trilhasArray = [Trilha]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let trilhasController = TrilhaTableViewController(nibName: "TrilhaTableViewController", bundle: nil)
        let usuarioController = UsuarioViewController(nibName: "UsuarioViewController", bundle: nil)
        
        let nav1 = UINavigationController()
        let nav2 = UINavigationController()
        
        // Insere ambos os views controllers em navigations controllers
        nav1.pushViewController(trilhasController, animated: false)
        nav2.pushViewController(usuarioController, animated: false)
        
        // Cria a TabBar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nav1,nav2]
        
        nav1.tabBarItem.title = "Trilhas"
        //nav1.tabBarItem.image = UIImage()
        nav2.tabBarItem.title = "Usuario"
        //nav2.tabBarItem.image = UIImage()
        
        // Configura o UITabBarController como o view controller principal
        self.window!.rootViewController = tabBarController
        self.window!.makeKeyAndVisible()
        */
        
        let http = NSURLSession.sharedSession()
        
        let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/searchTrail?token=99678f8f11be783c5e33c11008ba6772")!
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            let task = http.dataTaskWithURL(url) {(data, response, error ) -> Void in
                
                if(error != nil) {
                    print("URL Error!!")
                } else {
                    do {
                        let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                        self.CarregaTrilhas(object)
                    } catch let jsonError as NSError {
                        print( "JSONError: \( jsonError.localizedDescription )")
                    }
                }
            }
            task.resume()
        }



 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func CarregaTrilhas(trilhas: NSArray) {
        
        print(trilhas)
        
        for trilha:AnyObject in trilhas {
            
            let trilhaLocal = Trilha()
            
            let codigo = trilha["codigo"] as? Int
            let usuario = trilha["usuario"] as? NSDictionary
            let titulo = trilha["titulo"] as? String
            let sobre = trilha["sobre"] as? String
            let data = trilha["dataFormatada"] as? String
            let perfil = usuario!["perfil"] as? NSDictionary
            let nomeUsuario = usuario!["nome"]  as! String
            
            trilhaLocal.codigo = codigo!
            trilhaLocal.titulo = titulo!
            trilhaLocal.sobre = sobre!
            trilhaLocal.data = data!
            trilhaLocal.nomeUsuario = nomeUsuario
            
            /*
             trilhaLocal.usuario.nome = usuario!["nome"] as! String
             trilhaLocal.usuario.email = usuario!["email"] as! String
             trilhaLocal.usuario.matricula = usuario!["matricula"] as! Int
             trilhaLocal.usuario.perfil.codigo = perfil!["codigo"] as! Int
             trilhaLocal.usuario.perfil.descricao = perfil!["descricao"] as! String
             trilhaLocal.usuario.perfil.nome = perfil!["descricao"] as! String
             */
            
            
            trilhasArray.append(trilhaLocal)
            
            
            print("Codigo: \(trilhaLocal.codigo) ")
            print("Nome: \(trilhaLocal.nomeUsuario)")
            //print("Email: \(trilhaLocal.usuario.email)")
            print("Sobre: \(trilhaLocal.titulo)")
            print("Data: \(trilhaLocal.data)")
        }
        
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TrilhaTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TrilhaTableViewCell
        
        // Fetches the appropriate trilha for the data source layout.
        let trilha = trilhasArray[indexPath.row]
        
        
        cell.tituloTrilhaLabel.text = trilha.titulo
        cell.dataTrilhaLabel.text = trilha.data
        cell.nomeUsuarioLabel.text = trilha.nomeUsuario
        //cell.photoImageView.image = trilha.usuarioImage
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
