//
//  TestAccountManager.swift
//  Masterly
//
//  Created by Salah on 12/11/19.
//  Copyright © 2019 Newline. All rights reserved.
//

import UIKit

public typealias SelectedHandler = (TestAccountObject)->Void
public typealias BindingHandler = (TestAccountObject,AccountTableViewCell)->Void
public typealias TitleHandler = ((TestAccountObject)->String)

class TestAccountManager: NSObject {
     var production:TestAccountList=TestAccountList.init(.producation);
     var development:TestAccountList=TestAccountList.init(.development);
     static let shared: TestAccountManager = { TestAccountManager()} ()
    public override init() {
        super.init()
        
    }
}
