//
//  WLLineChartController.swift
//  TestChart2
//
//  Created by User on 07.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit
import Charts

class WLLineChartController: WLBaseController, ChartViewDelegate {
    
    //MARK: IBOutlets
    @IBOutlet fileprivate var chartView: LineChartView!
    
    //MARK: Properties
    var lineChartViewModel: WLLineChartViewModel!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Methods
    override func prepareParameters() {
        super.prepareParameters()
        
        prepareChartView()
        setupData()
    }
    
    fileprivate func prepareChartView() {
        self.chartView.chartDescription?.enabled = false
        self.chartView.dragEnabled = true
        self.chartView.setScaleEnabled(true)
        self.chartView.pinchZoomEnabled = true
        
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0
        
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 40
        leftAxis.axisMinimum = -10
        leftAxis.gridLineDashLengths = [2.5, 2.5]
        
        //chartView.rightAxis.enabled = false
        chartView.legend.form = .line
        chartView.animate(xAxisDuration: 2.5)
        
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = self
        
        chartView.delegate = self
    }
    
    fileprivate func setupData() {
        
        let set1 = LineChartDataSet(values: self.lineChartViewModel.fetchChartsValues(), label: "Temp, max C")
        set1.drawIconsEnabled = false
        
        set1.lineDashLengths = [2.5, 2.5]
        set1.highlightLineDashLengths = [2.5, 2.5]
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
        set1.formLineDashLengths = [2.5, 2.5]
        set1.formLineWidth = 1
        set1.formSize = 10
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        chartView.data = data
    }
    
}

extension WLLineChartController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = self.lineChartViewModel.listWeatherForecast[Int(value)].date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, MM"
        let value = dateFormatter.string(from: date)
        
        return value
    }
}
