//
//  TrilhaTableViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 16/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit


class TrilhaTableViewController: UITableViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tableViewTrilhas: UITableView!
    
    let trilha: Trilha = Trilha()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let http = NSURLSession.sharedSession()
        
        let url = NSURL( string: "http://www.ceuma.br/ServicosOnlineDev/servicosSextouNTI/searchTrail?token=99678f8f11be783c5e33c11008ba6772")!
        
        let task = http.dataTaskWithURL(url) {(data, response, error ) -> Void in
            
            if(error != nil) {
                print("URL Error!!")
            } else {
                do {
                    
                    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    dispatch_sync(dispatch_get_main_queue(), {
                        self.trilha.exibeTrilhas(object)
                        self.tableViewTrilhas.reloadData()
                    })
                    
                    
                } catch let jsonError as NSError {
                    print( "JSONError: \( jsonError.localizedDescription )")
                }
            }
        }
        task.resume()

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
        
        
        cell.tituloTrilhaLabel.text = trilha.titulo
        cell.dataTrilhaLabel.text = trilha.data
        cell.nomeUsuarioLabel.text = trilha.nomeUsuario
        cell.photoImageView.image = trilha.imagem == nil ? UIImage(named: "nophoto.jpg"): trilha.imagem
        
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
