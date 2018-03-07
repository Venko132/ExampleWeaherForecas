//
//  WLLineChartControllerViewModel.swift
//  TestChart2
//
//  Created by User on 07.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import Charts

class WLLineChartViewModel {
    
    //MARK: Properties
    fileprivate(set) var listWeatherForecast: Array<WLWeatherForecast> = [WLWeatherForecast]()
    
    //MARK: LifeCycle
    init(list: Array<WLWeatherForecast>) {
        self.listWeatherForecast = list
    }
    
    //MARK: Methods
    
    func fetchChartsValues() -> Array<ChartDataEntry> {
        let values = self.listWeatherForecast.enumerated().flatMap { (index, model) -> ChartDataEntry? in
            guard let tMax = model.tMaxDegC else { return nil }
            
            let chartData = ChartDataEntry(x: Double(index), y: tMax, icon: nil)
            return chartData
        }
        
        return values
    }
}
