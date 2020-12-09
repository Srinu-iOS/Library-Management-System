//
//  ConstantTools.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import UIKit
import KRActivityIndicatorView
import AVFoundation

class ConstantTools: NSObject {
    static let sharedConstantTool  = ConstantTools()
    
    // MARK:- Handle Indicator
    func startIndicator(view:UIView,action:String) {
        let activityIndicator = KRActivityIndicatorView()
        if(action == "start") {
            activityIndicator.isHidden = false
            activityIndicator.frame.size.height = 50
            activityIndicator.frame.size.width = 50
            activityIndicator.center = CGPoint(x: view.frame.size.width  / 2,
                                  y: view.frame.size.height / 2)
            view.addSubview(activityIndicator)
            activityIndicator.animating = true
            activityIndicator.startAnimating()
        } else {
            activityIndicator.frame.size.height = 0
            activityIndicator.frame.size.width = 0
            activityIndicator.animating = false
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    // MARK:- Email Validation
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    // check valid Mobile Number
    func isValidMobileNumber(phoneNumber: String) -> Bool {
        let PHONE_REGEX = "^[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phoneNumber)
        return result
    }
}

extension UIAlertController {
    static func customAlert(title: String, message: String = "", cancelButtonTitle: String = "", buttonTitle: String = "", handler: ((UIAlertAction) -> Void)? = nil,cancelHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelButtonTitle, style: .default, handler: cancelHandler)
        alertController.addAction(cancel)
        if buttonTitle != ""{
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
            alertController.addAction(action)
        }
        return alertController
    }
}
