//
//  LoginWithUserNameWithCustomePlistViewController.swift
//  TestAccountKitExample
//
//  Created by Salah on 8/26/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit
import TestAccountKit
class LoginWithUserNameWithCustomePlistViewController: UIViewController {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
                
               if (self.txtUserName.text ?? "").count == 0 {
               TestAccountList.init(.plistName("CustomTestAccountListDevelopment")).showAsAlert(TestAccountList.FetchType.direct,{ (item) -> String in
                        return "(\(item.accountDescription ?? "")) \(item.username ?? "")"
                       }, selectedObject: { object in
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
