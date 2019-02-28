
//
//  CustomUIButton.swift
//  HelpStartsHere
//
//  Created by mac on 13/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit
@IBDesignable
class CustomUIButton: UIButton {
    @IBInspectable var cornerRadius:CGFloat = 5
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }

}
