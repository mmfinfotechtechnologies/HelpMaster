//
//  ServiceCollectionViewCell.swift
//  HelpStartsHere
//
//  Created by mac on 13/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? #colorLiteral(red: 0.1137254902, green: 0.2431372549, blue: 0.4431372549, alpha: 1) : UIColor.white
            self.cellLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }

}
