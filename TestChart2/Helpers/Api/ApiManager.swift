//
//  ApiManager.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    typealias CompletionHandler = (_ data: Any?, _ error: WLApiError?) -> Void
    
    //MARK: Properties
    var sessionManager: SessionManager!
    
    //MARK: LifeCycle
    static let sharedInstance = ApiManager()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
}

//MARK:- Methods
extension ApiManager {
    
    //MARK: Download data
    class func downloadDocument(documentName: String, completionHandler: @escaping CompletionHandler, progressHandler: @escaping ((_ progress: Double)->())) {
        
        guard let path = Constants.API.baseUrl.stringByAppendingPathComponent(path: WLApiRouter.bradfordData.rawValue).convertToUrl() else {
            progressHandler(0)
            completionHandler(nil, nil)
            return
        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(documentName)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        ApiManager.sharedInstance.sessionManager.download(path, to: destination).response {
            response in
            print(response)
            
            guard response.error == nil, let fileUrl = response.destinationURL else {
                let error = WLApiError(with: response.error, data: nil)
                completionHandler(false, error)
                return
            }
            
            
            completionHandler(fileUrl, nil)
            
            }.downloadProgress { (progress) in
                let _progressValue = progress.fractionCompleted
                progressHandler(_progressValue)
        }
    }
}
