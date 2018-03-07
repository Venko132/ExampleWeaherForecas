//
//  WLBaseController.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import MBProgressHUD

class WLBaseController: UIViewController, WLProtocolProgress {

    //MARK: Properties
    public private(set) var progressHUD: MBProgressHUD?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareParameters()
    }
    
    //MARK: Methods
    func prepareParameters() {
    }
    
    //MARK: WLProtocolProgress
    func startProgress() {
        guard self.progressHUD == nil else { return }
        self.progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func endProgress() {
        self.progressHUD?.hide(animated: true)
        self.progressHUD = nil
    }
}
