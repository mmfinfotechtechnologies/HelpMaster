//
//  ServicesPopUpViewController.swift
//  HelpStartsHere
//
//  Created by mac on 13/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit
protocol ServicesPopUpDelegate {
    func serviceDone(with:[String])
}
class ServicesPopUpViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var delegate: ServicesPopUpDelegate?
    var data = ["Housing","Medical","Food Assistance","Mental Health","Substance Abuse","Transportation","Legal Services","Disaster Services","Other Services","Special Population","Financial Assistance"]
    var selectedData:[String] = []
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        servicesCollectionView.allowsMultipleSelection = true
        servicesCollectionView.dataSource = self
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        showAnimate()
        loadSelectedData()
    }
    func loadSelectedData(){
        for selected in selectedData{
            if let index = data.firstIndex(of: selected){
                let indexPath = IndexPath(item: index, section: 0)
                if let cell = servicesCollectionView.cellForItem(at: indexPath) as? ServiceCollectionViewCell{
                    cell.isSelected = true
                }else{
                    print("cell not found")
                }
            }else{
                print("index not found")
            }
        }
    }
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }
    
    @IBAction func cancel(_ sender: Any) {
        removeAnimate()
    }
    @IBAction func done(_ sender: Any) {
        selectedData = []
        for cell in servicesCollectionView.visibleCells{
            if cell.isSelected{
                selectedData.append((cell as! ServiceCollectionViewCell).cellLabel.text!)
            }
        }
        delegate?.serviceDone(with: selectedData)
        removeAnimate()
    }

}
extension ServicesPopUpViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = servicesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCollectionViewCell
        cell.cellLabel.text = data[indexPath.row]
        return cell
    }
}
