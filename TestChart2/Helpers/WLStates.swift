//
//  WLStates.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

enum WLResultEnum {
    case success(data: Any?)
    case failure(error: WLApiError?)
}

typealias CompletionHandlerViewModel = (_ result: WLResultEnum) -> Void
