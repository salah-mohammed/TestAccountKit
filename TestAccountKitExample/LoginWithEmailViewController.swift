//
//  LoginWithEmailViewController.swift
//  TestAccountKitExample
//
//  Created by Salah on 7/27/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit
import TestAccountKit
class LoginWithEmailViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }

    @IBAction func btnLogin(_ sender: UIButton) {
           #if DEBUG
               if (self.txtEmail.text ?? "").count == 0 {
                UIAlertController.showTestAccounts(sender,.development,TestAccountList.FetchType.direct,selectedHandler: { object in
                    self.txtEmail.text = object.email ?? "";
                    self.txtPassword.text = object.password ?? "";
                    self.login()
                } )
                
           }else{
               self.login()
           }
           #else
                self.login()
           #endif
    }
    func login(){
        
    }
}

