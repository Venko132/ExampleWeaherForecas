//
//  Constants.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

struct Constants {
    
    struct API {
        static let baseUrl: String = "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata"
    }
    
    struct Key {
        static let message: String = "message"
        static let hours: String = "hours"
    }
    
    struct Storyboard {
        static let main: String = "Main"
        static let chart: String = "Chart"
    }
    
    struct Message {
        static let errorTitle: String = "Error"
        static let errorMessage: String = "Something went wrong"
    }
    
    struct File {
        static let documentsList: String = "WLDocumentsList.plist"
    }
}
