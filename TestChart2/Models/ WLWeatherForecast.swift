//
//   WLWeatherForecast.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

struct WLWeatherForecast {
    
    fileprivate static let keysCount: Int = 7
    
    //MARK: Properties
    fileprivate(set) var date: Date
    fileprivate(set) var tMaxDegC: Double?
    fileprivate(set) var tMinDegC: Double?
    fileprivate(set) var afDays: Double?
    fileprivate(set) var mmRaine: Double?
    fileprivate(set) var sunHours: Double?
    
    //MARK: LifeCycle
    init?(data: String) {
        let _data = data.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if _data.count == 0 {
            return nil
        }
        
        var listValues = _data.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        listValues = listValues.flatMap({ (value) in
            let valueTransform = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines.union(CharacterSet.init(charactersIn: "*")))
            return valueTransform.count > 0 ? valueTransform : nil
        })
        //debugPrint("v: ", listValues)
        
        if listValues.count < WLWeatherForecast.keysCount {
            return nil
        }
        
        // 2.
        let year = listValues[0]
        let month = listValues[1]
        let tMax = listValues[2]
        let tMin = listValues[3]
        let afDays = listValues[4]
        let mmRaine = listValues[5]
        let sunHours = listValues[5]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM"
        guard let _date = dateFormatter.date(from: "\(year) \(month)") else { return nil }
        
        self.date = _date
        self.tMaxDegC = Double(tMax) 
        self.tMinDegC = Double(tMin)
        self.afDays = Double(afDays)
        self.mmRaine = Double(mmRaine)
        self.sunHours = Double(sunHours)
    }
    
}













