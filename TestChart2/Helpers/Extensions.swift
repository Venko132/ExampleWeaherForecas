//
//  Extensions.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

//MARK:- NSObject
extension NSObject {
    open class var kIdentifier: String  {
        get {
            return String(describing: self)
        }
    }
}

//MARK:- String
extension String {
    func pathUrlCoding() -> String {
        let result = self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        debugPrint("Encoding: ", self)
        return result ?? ""
    }
    
    func convertToUrl() -> URL? {
        let pathUrl = URL.init(string: self)
        return pathUrl
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    var lastPathComponent: String {
        get {
            return (self as NSString).lastPathComponent
        }
    }
    
    var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    
    var stringByDeletingLastPathComponent: String {
        get {
            return (self as NSString).deletingLastPathComponent
        }
    }
    
    var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).deletingPathExtension
        }
    }
    
    var pathComponents: [String] {
        get {
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)
    }
}
