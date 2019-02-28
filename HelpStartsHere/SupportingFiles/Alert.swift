//
//  Alert.swift
//  CfssApp
//
//  Created by mac on 30/01/19.
//  Copyright © 2019 mmfinfotech. All rights reserved.
//

import UIKit
class Alert {
    
    /**
     presents asimple UIAlertViewController with title message and ok button.
     
     - Parameters:
        - title: title of alert.
        - message : message to be shown.
        - vc : object of ViewController where it should be presented
     
    */
    class func showBasic(title: String, message: String, vc: UIViewController , CompletionHandler : (()->Void)?) {
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
            NSAttributedString.Key.foregroundColor : UIColor.orange
            ])
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.setValue(attributedString, forKey: "attributedTitle")
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: {
                if let handler = CompletionHandler{
                    handler()
                }
            })
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
        alert.view.tintColor = UIColor.orange
    }
    /**
     presents asimple UIAlertViewController with title message like android's toast.
     
     - Parameters:
        - title: title of alert.
        - message : message to be shown.
        - vc : object of ViewController where it should be presented.
        - time : time in second of showing.
     
     */
    class func toast(title: String, message: String, vc: UIViewController,time : Double, CompletionHandler : (()->Void)?) {
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold), //your font here
            NSAttributedString.Key.foregroundColor : UIColor.orange
            ])
        let alert = UIAlertController(title:"", message:message, preferredStyle: UIAlertController.Style.alert)
        alert.setValue(attributedString, forKey: "attributedTitle")
        vc.present(alert, animated: true) {
            Timer.scheduledTimer(withTimeInterval:time , repeats: false, block: {_ in
                vc.dismiss(animated: true, completion: {
                    if let handler = CompletionHandler{
                        handler()
                    }
                })
            })
        }
        alert.view.tintColor = UIColor.orange
    }
}
