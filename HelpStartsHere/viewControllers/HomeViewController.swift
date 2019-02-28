//
//  HomeViewController.swift
//  HelpStartsHere
//
//  Created by mac on 19/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var describeView: UIView!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var clientView: UIView!
    var didSetOption: ((_ option : launchOptions) -> Void)?
    var option : launchOptions = .describe
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func describeClicked(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.describeView.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85)
        }
        option = .describe
        didSetOption?(option)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selctServiceClicked(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.serviceView.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85)
        }
        option = .selectService
        didSetOption?(option)

        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clientInfoCliced(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.clientView.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85)
        }
        option = .client
        didSetOption?(option)
        self.navigationController?.popViewController(animated: true)
    }
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showGetHelp"{
//            if let vc = segue.destination as? GetHelpViewController{
//                vc.option = self.option
//            }
//        }
    }
    

}
