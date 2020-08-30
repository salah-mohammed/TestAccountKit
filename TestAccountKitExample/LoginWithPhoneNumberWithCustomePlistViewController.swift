//
//  LoginWithPhoneNumberViewController.swift
//  TestAccountKitExample
//
//  Created by Salah on 7/27/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit
import TestAccountKit
class LoginWithPhoneNumberWithCustomePlistViewController: UIViewController {
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
               if (self.txtPhoneNumber.text ?? "").count == 0 {
                TestAccountList.init(.plistStringURL(Bundle.main.path(forResource:"CustomTestAccountListDevelopment", ofType: "plist")!)).show({ (item) -> String in
                    return "(\(item.accountDescription ?? "")) \(item.phoneNumber ?? "")"
                }, selectedObject:  { object in
                               self.txtPhoneNumber.text = object.phoneNumber ?? "";
                               self.login()
                          })
                
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
