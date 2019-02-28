//
//  LoginViewController.swift
//  HelpStartsHere
//
//  Created by mac on 13/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting button round.
    }
    @IBAction func loginPressed(_ sender: Any) {
        //validations
        if emailField.text?.isValidEmail() ?? false{
            if !(passwordField.text?.isEmpty ?? true){
                //make transition to next screen.
                performSegue(withIdentifier: "login", sender: self)
            }else{
                passwordField.shake()
            }
        }else{
            emailField.shake()
        }
    }
}
