//
//  HelperManager.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

class HelperManager {
    
    //MARK: Properties
    static let sharedInstance = HelperManager()
    fileprivate var alertViewDB: DBAlertController?
    
    //MARK: LifeCycle
    private init() {
        
    }
}

//MARK:- Methods
extension HelperManager {
    //MARK: Alert
    class func showDBAlert(title: String?, message: String?) {
        
        DispatchQueue.main.async (flags: .barrier) {
            
            if HelperManager.sharedInstance.alertViewDB != nil {
                return
            }
            
            HelperManager.sharedInstance.alertViewDB = DBAlertController(title: title, message: message, preferredStyle: .alert)
            HelperManager.sharedInstance.alertViewDB?.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (alert) in
                HelperManager.sharedInstance.alertViewDB = nil
            }))
            HelperManager.sharedInstance.alertViewDB?.show()
        }
    }
    
    class func showError(_ error: WLApiError) {
        var strErrorMessage: String? = nil
        strErrorMessage = error.message ?? error.localizedDescription
        
        debugPrint("Error: \(strErrorMessage ?? "___errorMessage___")")
        HelperManager.showDBAlert(title: Constants.Message.errorTitle, message: strErrorMessage)
    }
    
    //MARK: Blocked Touches
    class func blockedInteractionEvents(time: Double = 0.3, contentView: UIView? = nil, _ handler: (()->Void)? = nil) {
        DispatchQueue.main.async {
            contentView?.isUserInteractionEnabled = false
            UIApplication.shared.beginIgnoringInteractionEvents()
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                UIApplication.shared.endIgnoringInteractionEvents()
                contentView?.isUserInteractionEnabled = true
                if (handler != nil) {
                    handler!()
                }
            }
        }
    }
    
    //MARK: Controller
    class func getController(_ vcIdentifier: String, forStoryboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: forStoryboardName, bundle: nil)
        let vcController = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
        
        return vcController
    }
    
    //MARK: Formatted string
    class func getFormattedStringFromNumber(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        //numberFormatter.positiveFormat = "###0.##"
        return numberFormatter.string(from: NSNumber.init(value: number))!
    }
}








