//
//  WLApiErrror.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WLApiError: Error {
    var localizedDescription: String
    var code: Int? = nil
    var message: String? = nil
    var userInfo: [String: Any]? = nil
    
    init(with error: Error?, data: JSON?) {
        self.localizedDescription = error?.localizedDescription ?? "Unknow error"
        
        if let _error = error as NSError? {
            self.userInfo = _error.userInfo
            self.code = _error.code
        }
        
        if let _dataDictionary = data?.dictionaryObject {
            self.userInfo = _dataDictionary
            if let _data = data, let _message = _data[Constants.Key.message].string {
                self.message = _message
            }
        }
    }
}
