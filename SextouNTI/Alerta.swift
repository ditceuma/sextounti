//
//  Alerta.swift
//  SextouNTI
//
//  Created by Michel Cordeiro on 20/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit


class Alerta {
    
    
    class func alerta(msg : String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}