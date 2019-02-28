//
//  CordinatorViewController.swift
//  HelpStartsHere
//
//  Created by mac on 19/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit
import SideMenu
class CordinatorViewController: UIViewController {
    var sideMenuVc : SideMenuViewController!

    @IBOutlet weak var containerView: UIView!
    var viewToBeAdded:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetHelpViewController") as! GetHelpViewController
        self.addChild(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
        self.viewToBeAdded = vc.view
        self.containerView.addSubview(self.viewToBeAdded!)
        vc.didMove(toParent: self)
        sideMenuVc = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
        setUpSideMenu()
        sideMenuVc.didTapped = {withOption in
            switch withOption {
            case .request:
                SideMenuManager.default.menuLeftNavigationController?.dismiss(animated: true, completion: {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetHelpViewController") as! GetHelpViewController
                    self.addChild(vc)
                    vc.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
                    if let viewTo = self.viewToBeAdded{
                        viewTo.removeFromSuperview()
                        self.viewToBeAdded = nil
                    }
                    self.viewToBeAdded = vc.view
                    self.containerView.addSubview(self.viewToBeAdded!)
                    vc.didMove(toParent: self)
                })
            case .draft:
                SideMenuManager.default.menuLeftNavigationController?.dismiss(animated: true, completion: {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DraftViewController") as! DraftViewController
                    self.addChild(vc)
                    vc.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
                    if let viewTo = self.viewToBeAdded{
                        viewTo.removeFromSuperview()
                        self.viewToBeAdded = nil
                    }
                    self.viewToBeAdded = vc.view
                    self.containerView.addSubview(self.viewToBeAdded!)
                    vc.didMove(toParent: self)
                    
                })
            case .sent:
                SideMenuManager.default.menuLeftNavigationController?.dismiss(animated: true, completion: {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SentViewController") as! SentViewController
                    self.addChild(vc)
                    vc.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
                    if let viewTo = self.viewToBeAdded{
                        viewTo.removeFromSuperview()
                        self.viewToBeAdded = nil
                    }
                    self.viewToBeAdded = vc.view
                    self.containerView.addSubview(self.viewToBeAdded!)
                    vc.didMove(toParent: self)
                })
            }
        }
        // Do any additional setup after loading the view.
    }
    func setUpSideMenu(){
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: sideMenuVc)
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuDismissOnPush = true
        menuLeftNavigationController.sideMenuManager.menuPresentMode = .menuSlideIn
        menuLeftNavigationController.sideMenuManager.menuWidth = self.view.frame.width * 0.50
    }
    @IBAction func menuButtonClicked(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }

}
