//
//  WLStartController.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class WLStartController: WLBaseController {
    
    fileprivate static let kCityCellIdentifier = "kCityCellIdentifier"
    fileprivate static let kData = "data"
    
    //MARK: IBOutlets
    @IBOutlet fileprivate weak var tblView: UITableView!

    //MARK: Properties
    fileprivate let startViewModel = WLStartViewModel()
    fileprivate var startCoordinator: WLStartCoordinator?
    fileprivate var mbProgressLoading: MBProgressHUD?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Methods
    override func prepareParameters() {
        super.prepareParameters()
        
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.tblView.tableFooterView = UIView()
        
        self.startCoordinator = WLStartCoordinator(navController: self.navigationController)
    }
    
    //MARK: WLProtocolProgress
    override func startProgress() {
        guard self.mbProgressLoading == nil else { return }
        self.mbProgressLoading = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.mbProgressLoading?.mode = .determinate
        self.mbProgressLoading?.label.text = "Loading..."
        self.mbProgressLoading?.progress = 0.0
    }
    
    override func endProgress() {
        self.mbProgressLoading?.hide(animated: true)
        self.mbProgressLoading = nil
    }
}

//MARK:- UITableViewDataSource & UITableViewDelegate
extension WLStartController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.startViewModel.listFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = configureCell(at: indexPath)
        
        cell.selectionStyle = .none
        return cell
    }
    
    fileprivate func configureCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: WLStartController.kCityCellIdentifier)

        cell.textLabel?.text = self.startViewModel.listFiles[indexPath.row].trimmingCharacters(in: CharacterSet.init(charactersIn: WLStartController.kData)).capitalized
        
        return cell
    }
    
    fileprivate func selectedCell(at index: Int) {
        startProgress()
        
        self.startViewModel.openDocument(at: index,
                                         completionHandler:
        { [weak self](result) in
        
            guard let weakSelf = self else { return }
            weakSelf.endProgress()
            
            switch result {
            case .success(let data): do {
                guard let _data = data, let pathUrl = _data as? URL else { return }
                    weakSelf.startCoordinator?.routeToDetailInfo(filePath: pathUrl)
                }
            case .failure(let error): do {
                    if let _error = error {
                        HelperManager.showError(_error)
                    }
                }
            }
                
        }, progress: { [weak self](progressValue) in
            self?.mbProgressLoading?.progress = Float(progressValue)
        })
    }
}







