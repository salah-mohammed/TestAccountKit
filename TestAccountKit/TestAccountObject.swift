//
//  TestAccountObject.swift
//  Masterly
//
//  Created by Salah on 12/10/19.
//  Copyright © 2019 Newline. All rights reserved.
//

import UIKit

public class TestAccountObject: NSObject {
    open var accountDescription:String?
    open var username:String?;
    open var email:String?;
    open var phoneNumber:String?;
    open var password:String?;
    open var other:String?;
     init(dic:[String:Any]) {
        super.init()
        self.accountDescription = dic["accountDescription"] as? String
        self.username = dic["username"] as? String
        self.email = dic["email"] as? String
        self.phoneNumber = dic["phoneNumber"] as? String
        self.password = dic["password"] as? String
        self.other = dic["other"] as? String
        
    }
}
