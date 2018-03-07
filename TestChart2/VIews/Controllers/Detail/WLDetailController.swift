//
//  WLDetailController.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

class WLDetailController: WLBaseController {
    
    fileprivate let heightOfCell: CGFloat = 115.0
    
    //MARK: IBOutlets
    @IBOutlet fileprivate weak var tblView: UITableView!
    @IBOutlet fileprivate weak var segmentControl: UISegmentedControl!
    
    //MARK: Properties
    var detailViewModel: WLDetailViewModel!
    fileprivate var detailCoordinator: WLDetailCoordinator!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Methods
    override func prepareParameters() {
        super.prepareParameters()
        
        prepareNavBar()
        self.detailCoordinator = WLDetailCoordinator.init(navController: self.navigationController)
        self.detailViewModel.readFileData()
        
        self.tblView.dataSource = self
        self.tblView.delegate = self
        
        let cellNib = UINib.init(nibName: WLWeatherForecastCell.kIdentifier, bundle: nil)
        self.tblView.register(cellNib, forCellReuseIdentifier: WLWeatherForecastCell.kIdentifier)
        
        self.tblView.tableFooterView = UIView()
        
        self.detailViewModel.changedSortingType = { () in
            self.tblView.reloadData()
        }
    }
    
    fileprivate func prepareNavBar() {
        let rightItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: self, action: #selector(openCharts))
        
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc fileprivate func openCharts() {
        self.detailCoordinator.routeToChart(list: self.detailViewModel.listWeatherForecast)
    }
    
    //MARK: Actions
    @IBAction fileprivate func actionChangeSoringType(_ sender: UISegmentedControl) {
        self.detailViewModel.sortingType = WLDetailViewModel.SortingType(rawValue: sender.selectedSegmentIndex)!
    }
}

//MARK:- UITableViewDataSource & UITableViewDelegate
extension WLDetailController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailViewModel.listWeatherForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = configureCell(at: indexPath)
        
        cell.selectionStyle = .none
        return cell
    }
    
    fileprivate func configureCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: WLWeatherForecastCell.kIdentifier) as! WLWeatherForecastCell
        
        let weatherModel = self.detailViewModel.listWeatherForecast[indexPath.row]
        cell.configure(data: weatherModel)
        
        return cell
    }
}
