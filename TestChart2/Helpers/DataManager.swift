//
//  DataManager.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

class DataManager {
    //MARK: Properties
    static let sharedInstance = DataManager()
    
    //MARK: LifeCycle
    private init() {
        
    }
}

//MARK:- Methods
extension DataManager {
    class func documentDirectoryPath(fileName: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        return fileURL
    }
    
    class func checkExistingOfFile(name: String) -> Bool {
        let documentURL = DataManager.documentDirectoryPath(fileName: name)
        
        return FileManager.default.fileExists(atPath: documentURL.path)
    }
    
    class func openExistingDocument(name: String) -> String? {
        let documentURL = DataManager.documentDirectoryPath(fileName: name)
        
        return openExistingDocument(pathUrl: documentURL)
    }
    
    class func openExistingDocument(pathUrl: URL) -> String? {
        guard let documentData = FileManager.default.contents(atPath: pathUrl.path) else {
            return nil
        }
        
        let documentContent = String.init(data: documentData, encoding: String.Encoding.utf8)
        return documentContent
    }
}




