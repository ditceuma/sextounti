//
//  MD5.swift
//  SextouNTI
//
//  Created by Rabelo on 15/05/16.
//  Copyright © 2016 br.com.fagutapp. All rights reserved.
//

import UIKit

class MD5 {
    
    func digest(string string: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    //Test:
    //let digest = md5(string:"Hello")
    //print("digest: \(digest)")
}
