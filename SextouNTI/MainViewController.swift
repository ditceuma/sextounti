//
//  MainViewController.swift
//  SextouNTI
//
//  Created by Rabelo on 21/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

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
        self.view.window!.rootViewController = tabBarController
        self.view.window!.makeKeyAndVisible()
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
