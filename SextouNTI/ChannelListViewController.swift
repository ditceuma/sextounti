//
//  GoupListViewController.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 15/11/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ChannelListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // MARK: Properties
    var newChannelTextField = UITextField()
    var filteredChannels = [Channel]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var channels: [Channel] = []
    var senderDisplayName: String? 
    
    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }

    }
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredChannels = channels.filter { chanel in
            let categoryMatch = (scope == "All") || (channel.category == scope)
            return  categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("grupos").observeEventType(.Value, withBlock: { (snapshot) in
            
            print(snapshot)
            if let grupos = snapshot.value as? NSDictionary {
                
                for (_, grupo) in grupos  {
                    
                    if let novoGrupo = grupo as? NSDictionary {
                        
                        self.channels.append(Channel(dictionary: novoGrupo)!)
                    }
                }
               
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }

        self.tableView.reloadData()
    }
    
    // MARK: Actions
    
    @IBAction func criaGrupo(sender: AnyObject) {
        
        if let novoGrupo =  self.newChannelTextField.text {
            
            let grupo = Channel()
            grupo?.name = novoGrupo
            grupo?.owner = usuarioLogin.uid!
            
            let grupoDict = grupo?.dictionaryRepresentation()
            
            ref.child("grupos").childByAutoId().setValue(grupoDict)
            
            channels.append(grupo!)
            
            tableView.reloadData()
        }
    }
    

    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 2
        if let currentSection: Section = Section(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelsSection:
                return channels.count
            }
        } else {
            return 0
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = indexPath.section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        if indexPath.section == Section.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if indexPath.section == Section.currentChannelsSection.rawValue {
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        
        return cell
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


extension ChannelListViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension ChannelListViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
