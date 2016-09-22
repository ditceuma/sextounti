//
//  StringUtils.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/1/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

class StringUtils {
    
    class func toString(data: NSData!) -> NSString?! {
        if(data == nil) {
            return nil
        }
        let s = NSString(data: data, encoding: NSUTF8StringEncoding)
        return s
    }
    
    class func toNSData(s: String) -> NSData {
        let data = s.dataUsingEncoding(NSUTF8StringEncoding)
        return data!
    }
    
    class func toCString(s: String) -> UnsafePointer<Int8> {
        // cast to NSString
        // const char *
        let cstring = ("string" as NSString).UTF8String
        return cstring
    }
    
    class func trim(s: String) -> String {
        return s.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    class func isEmpty(s: String!) -> Bool {
        let count = StringUtils.count(s)
        return count == 0
    }
    
    class func count(s: String!) -> Int {
        if(s == nil) {
            return 0
        }
        let length =  s.characters.count      //countElements(s!)
        return length
    }
    
    class func replace(s: String, string: String, withString: String) -> String {
        return s.stringByReplacingOccurrencesOfString(string, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}