//
//  WLStartControllerViewModel.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

class WLStartViewModel {
    
    //MARK: Properties
    fileprivate(set) var listFiles: Array<String> = [String]()
    var resultBlock: CompletionHandlerViewModel?
    
    //MARK: LifeCycle
    init() {
        fetchListDocuments()
    }
    
    //MARK: Methods
    fileprivate func fetchListDocuments() {
        guard let documentContent = Bundle.main.url(forResource: Constants.File.documentsList, withExtension: nil),
            let cities = NSArray.init(contentsOf: documentContent) as? Array<String> else { return }
        
        self.listFiles = cities
    }
    
    func openDocument(at index: Int, completionHandler: @escaping CompletionHandlerViewModel, progress: @escaping ((Double) -> ()) ) {
        self.resultBlock = completionHandler
        let fileName = self.listFiles[index]
        
        guard !DataManager.checkExistingOfFile(name: fileName) else {
            self.resultBlock!(.success(data: DataManager.documentDirectoryPath(fileName: fileName)))
            return
        }
        
        fetchRemoteDocument(name: fileName, progress: progress)
    }
    
    //MARK: API
    fileprivate func fetchRemoteDocument(name: String, progress: @escaping ((Double) -> ()) ) {
        
        ApiManager.downloadDocument(documentName: name, completionHandler: { [weak self](data, error) in
            guard let weakSelf = self, let _resultBlock = weakSelf.resultBlock else { return }
            
            guard error == nil else {
                _resultBlock(.failure(error: error))
                return
            }
            
            _resultBlock(.success(data: data))
        }, progressHandler: progress)
    }
}






