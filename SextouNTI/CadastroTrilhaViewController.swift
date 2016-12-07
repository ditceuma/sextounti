//
//  CadastroTrilhaViewController.swift
//  SextouNTI
//
//  Created by Flavio Rabelo on 06/11/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CadastroTrilhaViewController: UIViewController {
    
    // MARK: properties
    @IBOutlet weak var tituloTrilha: UITextView!
    @IBOutlet weak var sobreTrilha: UITextView!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var dataTrilha: UILabel!
    
    let ref = FIRDatabase.database().reference()
    
    var trilha: Trilha = Trilha()!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tituloTrilha.layer.borderWidth = 1.0;
        tituloTrilha.layer.borderColor = UIColor.blackColor().CGColor
        
        sobreTrilha.layer.borderWidth = 1.0;
        sobreTrilha.layer.borderColor = UIColor.blackColor().CGColor

        // Do any additional setup after loading the view.
    }

    
    // MARK: Actions
    
    @IBAction func datePickerAction(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(myDatePicker.date)
        self.dataTrilha.text = strDate
        
    }
    
    
    @IBAction func salvarTrilha(sender: AnyObject) {
        
        var trilhaDic : [String:AnyObject] = [:]
        
        if let titulo = tituloTrilha.text {
            if let sobre = sobreTrilha.text {
                if let data = dataTrilha.text {
                    trilha.titulo = titulo
                    trilha.sobre = sobre
                    trilha.dataFormatada = data
                    trilha.likes = 0
                    trilha.comentarios = 0
                    trilha.usuarioSocial = usuarioLogin
                    
                    let dicionario = trilha.dictionaryRepresentation()
                    
                    trilhaDic["TITULO"] = dicionario["titulo"]
                    trilhaDic["SOBRE"] = dicionario["sobre"]
                    trilhaDic["DATA_EVENTO"] = dicionario["dataFormatada"]
                    trilhaDic["FK_USUARIO"] = usuarioLogin.uid
                    
                    print(trilhaDic)
                    
                    self.ref.child("trilhas").childByAutoId().setValue(trilhaDic)
                    
                    
                }
            }
            
        }
        
        
        
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
