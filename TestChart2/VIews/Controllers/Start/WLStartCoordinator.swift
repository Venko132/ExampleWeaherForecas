//
//  WLStartControllerCoordinator.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

class WLStartCoordinator {
    
    //MARK: Properties
    fileprivate var navController: UINavigationController?
    
    //MARK: LifeCycle
    init(navController: UINavigationController?) {
        self.navController = navController
    }
    
    func routeToDetailInfo(filePath: URL) {
        let vcDetail = HelperManager.getController(WLDetailController.kIdentifier, forStoryboardName: Constants.Storyboard.main) as! WLDetailController
        
        vcDetail.detailViewModel = WLDetailViewModel.init(filePath: filePath)
        
        self.navController?.pushViewController(vcDetail, animated: true)
    }
}
