//
//  WLDetailControllerViewModel.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

class WLDetailViewModel {
    
    enum SortingType: Int {
        case year
        case tMin
        case tMax
    }
    
    //MARK: Properties
    var changedSortingType: (() -> ())?
    
    fileprivate var content: String = ""
    fileprivate var filePath: URL!
    fileprivate(set) var listWeatherForecast: Array<WLWeatherForecast> = [WLWeatherForecast]()
    
    var sortingType: WLDetailViewModel.SortingType = .year {
        didSet {
            if oldValue != self.sortingType {
                self.listWeatherForecast = self.listWeatherForecast.sorted(by: { (v0, v1) -> Bool in
                    var result: Bool = true
                    switch self.sortingType {
                    case .year:
                        result = v0.date.compare(v1.date) == .orderedAscending ? true : false
                    case .tMin: do {
                        guard let min0 = v0.tMinDegC else { return false}
                        guard let min1 = v1.tMinDegC else { return true}
                        result = min0 < min1 ? true : false
                        }
                    case .tMax: do {
                        guard let min0 = v0.tMaxDegC else { return false}
                        guard let min1 = v1.tMaxDegC else { return true}
                        result = min0 > min1 ? true : false
                        }
                    }
                    
                    return result
                })
            }
            
            if self.changedSortingType != nil {
                changedSortingType!()
            }
        }
    }
    
    //MARK: LifeCycle
    init(filePath: URL) {
        self.filePath = filePath
    }
    
    //MARK: Methods
    func readFileData() {
        self.content = DataManager.openExistingDocument(pathUrl: filePath) ?? ""
        parseFileContent()
    }
    
    fileprivate func parseFileContent() {
        // 1.
        let _content = self.content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if _content.count == 0 {
            return
        }
        
        // 2.
        var strContent: NSString = _content as NSString
        let _range = strContent.range(of: Constants.Key.hours)
        if _range.location == NSNotFound {
            return
        }
        
        strContent = strContent.substring(from: _range.location + Constants.Key.hours.count) as NSString
        strContent = strContent.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        
        // 3.
        let listLines = strContent.components(separatedBy: CharacterSet.newlines)
        
        self.listWeatherForecast = listLines.flatMap({ WLWeatherForecast.init(data: $0) })
    }
}









