//
//  WLDetailControllerCoordinator.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

class WLDetailCoordinator {
    
    //MARK: Properties
    fileprivate var navController: UINavigationController!
    
    //MARK: LifeCycle
    init(navController: UINavigationController?) {
        self.navController = navController
    }
    
    func routeToChart(list: [WLWeatherForecast]) {
        let vcChart = HelperManager.getController(WLLineChartController.kIdentifier, forStoryboardName: Constants.Storyboard.chart) as! WLLineChartController
        
        vcChart.lineChartViewModel = WLLineChartViewModel.init(list: list)
        
        self.navController?.pushViewController(vcChart, animated: true)
    }
}
