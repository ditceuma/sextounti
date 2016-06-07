//
//  TrilhaTableViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 16/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

var trilhasArray = [Trilha]()

class TrilhaTableViewController: UITableViewController {
    
    
    @IBOutlet weak var tableViewTrilhas: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(animated: Bool) {


    }
    
    override func viewWillAppear(animated: Bool) {
        
        tableViewTrilhas.reloadData()
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
        //cell.photoImageView.image = trilha.usuarioImage
        
        return cell
    }



    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc: DetalheTrilhaViewController =  segue.destinationViewController as! DetalheTrilhaViewController
        
        let path = tableViewTrilhas.indexPathForSelectedRow
        let trilha = trilhasArray[path!.row]
        
        vc.trilha = trilha
        
    }

}
