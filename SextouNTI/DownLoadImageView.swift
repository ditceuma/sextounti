//
//  DownloadImageView.swift
//  Carros
//
//  Created by Rabelo on 02/04/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import UIKit

class DownloadImageView : UIImageView  {
    
    // Para exibir a animação durante o download
    var progress: UIActivityIndicatorView!
    // Fila para fazer o download em backgroud
    let queue = NSOperationQueue()
    // Fila principal para atualizar a interface
    let mainQueue = NSOperationQueue.mainQueue()
    // Construtor
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        createProgress()
    }
    
    // Construtor
    override init(frame: CGRect) {
        super.init(frame: frame)
        createProgress()
    }
    
    // Cria o UIActivityIndicatorView e adiciona por cima da imagem
    func createProgress() {
        
        progress = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        addSubview(progress)
    }
    
    override func layoutSubviews() {
        // Posiciona o progress no centro
        progress.center = convertPoint(self.center, fromView: self.superview)
    }
    
    // Faz o download da URL, defaut é com cache
    func setUrl(url: String) {
        setUrl(url, cache: true)
        
    }
    
    func setUrl(url: String, cache: Bool) {
        
        self.image = nil
        queue.cancelAllOperations()
        // Inicia a animação
        progress.startAnimating()
        // Executa o download em background
        queue.addOperationWithBlock({self.downloadImg(url, cache: true) })
    }
    
    func downloadImg(url: String, cache: Bool)  {
        
        var data: NSData!
        
        if(!cache) {
            // Download
            data = NSData(contentsOfURL: NSURL(string: url)!)
        } else {
            
            // Cria o caminho para ler ou salvar o arquivo
            var path = StringUtils.replace(url, string: "/", withString: "_")
            path = StringUtils.replace(path, string: "\\", withString: "_")
            path = StringUtils.replace(path, string: ":", withString: "_")
            path = NSHomeDirectory() + "/Documents/" + path
            // Se o arquivo existe no cache
            let exists = NSFileManager.defaultManager().fileExistsAtPath(path)      // default.fileExists(atPath: path)
            if(exists) {
                // Lê do arquivo
                data = NSData(contentsOfFile: path)
            } else {
                // Download
                data =  NSData(contentsOfURL: NSURL(string: url)!)!
                // Salva no arquivo
                data.writeToFile( path, atomically: true)
            }
        }
            
            // Atualiza a view na thread de interface
            mainQueue.addOperationWithBlock({self.showImg(data)})
    }
            
    // Atualiza a imagem do UIImageView
    func showImg(data: NSData) {
    
        if(data.length > 0) {
            self.image = UIImage(data: data)
        }
        // Para a animação
        progress.stopAnimating()
    }
    
            
}


