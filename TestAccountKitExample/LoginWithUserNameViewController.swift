//
//  LoginViewController.swift
//  TestAccountKitExample
//
//  Created by Salah on 7/27/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit
import TestAccountKit
class LoginWithUserNameViewController: UIViewController {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }

    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
               if (self.txtUserName.text ?? "").count == 0 {
                UIAlertController.show(.development, TestAccountList.FetchType.inDirect,{ (item) -> String in
                    return "(\(item.accountDescription ?? "")) \(item.username ?? "")"
                }, selectedHandler: { object in
        self.txtUserName.text=object.username
        self.txtPassword.text=object.password

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

