//
//  WLWeatherForecastCell.swift
//  TestChart2
//
//  Created by User on 07.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class WLWeatherForecastCell: UITableViewCell {

    fileprivate let dateFormatString = "yyyy, MMM"
    
    //MARK: IBOutlets
    @IBOutlet fileprivate weak var lblDate: UILabel!
    @IBOutlet fileprivate weak var lblTempMax: UILabel!
    @IBOutlet fileprivate weak var lblTempMin: UILabel!
    @IBOutlet fileprivate weak var lblDays: UILabel!
    @IBOutlet fileprivate weak var lblRainMM: UILabel!
    @IBOutlet fileprivate weak var lblSunHours: UILabel!
    
    @IBOutlet fileprivate var listInfoLabels: Array<UILabel>!
    
    //MARK: Properties
    fileprivate var dateFormatter: DateFormatter {
        get {
            let dFormatter = DateFormatter()
            dFormatter.dateFormat = dateFormatString
            return dFormatter
        }
    }
    
    //MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.listInfoLabels.forEach({ $0.text = "" })
    }
    
    func configure(data model: WLWeatherForecast) {
        self.lblDate.text = self.dateFormatter.string(from: model.date).uppercased()
        self.lblDays.text = covert(value: model.afDays)
        self.lblRainMM.text = covert(value: model.mmRaine)
        self.lblTempMax.text = covert(value: model.tMaxDegC)
        self.lblTempMin.text = covert(value: model.tMinDegC)
        self.lblSunHours.text = covert(value: model.sunHours)
    }
    
    fileprivate func covert(value: Double?) -> String {
        guard let _value = value else {
            return "---"
        }
        
        let result = HelperManager.getFormattedStringFromNumber(number: _value)
        return result
    }
}








