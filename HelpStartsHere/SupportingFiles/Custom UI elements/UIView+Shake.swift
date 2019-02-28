//
//  UIView+Shake.swift
//  HelpStartsHere
//
//  Created by mac on 13/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit
extension UIView{
    func shake(){
        let midX = self.center.x
        let midY = self.center.y
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midX - 10, y: midY)
        animation.toValue = CGPoint(x: midX + 10, y: midY)
        layer.add(animation, forKey: "position")

    }
}
