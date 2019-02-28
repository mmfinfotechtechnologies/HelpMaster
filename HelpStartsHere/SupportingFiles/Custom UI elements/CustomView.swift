//
//  CustomView.swift
//  HelpStartsHere
//
//  Created by mac on 14/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit
protocol CustomViewDelegate {
    func buttonClicked(withTag:Int)
}
@IBDesignable
class CustomView: UIView {
    @IBInspectable var placeHolder:String = "label"
    @IBInspectable var radius:CGFloat = 5
    var delegate: CustomViewDelegate?
    var label = UILabel()
    var button = UIButton()
    @IBInspectable var buttonImage : UIImage = #imageLiteral(resourceName: "close-button"){
        didSet{
            button.setImage(buttonImage, for: .normal)
        }
    }
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        label.text = placeHolder
        button.setImage(buttonImage, for: .normal)
        label.frame = CGRect(x: 10, y: 5, width: self.frame.width - 60, height: self.frame.height - 10)
        button.frame = CGRect(x: label.frame.maxX + 10, y: label.frame.midY - 10, width: 20, height: 20)
        button.addTarget(self, action: #selector(buttonClicked(with:)), for: .touchUpInside)
        label.text = placeHolder
        button.setImage(buttonImage, for: .normal)
        self.addSubview(label)
        self.addSubview(button)
    }
    @objc func buttonClicked(with:UIButton){
        self.isHidden = true
        delegate?.buttonClicked(withTag: self.tag)
    }
}
