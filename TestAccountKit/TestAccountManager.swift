//
//  TestAccountManager.swift
//  Masterly
//
//  Created by Salah on 12/11/19.
//  Copyright © 2019 Newline. All rights reserved.
//

import UIKit

public class TestAccountManager: NSObject {
    public var production:TestAccountList=TestAccountList.init(.producation);
    public var development:TestAccountList=TestAccountList.init(.development);
    
    public static let shared: TestAccountManager = { TestAccountManager()} ()
    public override init() {
        super.init()
        
    }
}
