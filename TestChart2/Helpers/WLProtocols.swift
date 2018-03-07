//
//  WLProtocols.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

protocol WLProtocolProgress: class {
    func startProgress()
    func endProgress()
}

extension WLProtocolProgress {
    func startProgress() {}
    func endProgress() {}
}
