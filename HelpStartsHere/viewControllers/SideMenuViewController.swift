//
//  SideMenuViewController.swift
//  HelpStartsHere
//
//  Created by mac on 14/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit
import SideMenu
class SideMenuViewController: UIViewController {
    var didTapped : ((_ withOption:optionTapped) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func requestTapped(_ sender: Any) {
       didTapped?(.request)
    }
    @IBAction func draftTapped(_ sender: Any) {
        didTapped?(.draft)
    }
    @IBAction func sentTapped(_ sender: Any) {
        didTapped?(.sent)
    }
}
enum optionTapped{
    case request
    case draft
    case sent
}
