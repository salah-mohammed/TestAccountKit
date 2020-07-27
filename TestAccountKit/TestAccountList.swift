//
//  TestAccountList.swift
//  Masterly
//
//  Created by Salah on 12/10/19.
//  Copyright © 2019 Newline. All rights reserved.
//

import UIKit



public class TestAccountList: NSObject {
    public enum AccountType{
    case development
    case producation
    case customName(String)
    case stringURL(String)

    var stringURL:String?{
            switch self {
            case .development:
                return TestAccountList.toStringURL(plistName:"TestAccountListDevelopment");
            case .producation:
                return TestAccountList.toStringURL(plistName:"TestAccountListProducation");
            case .customName(let plistName):
                return TestAccountList.toStringURL(plistName:plistName);
            case .stringURL(let url):
                return url;
            }
            return nil;
        }
    }
    static func toStringURL(plistName:String)->String?{
     return Bundle.main.path(forResource:plistName, ofType: "plist")
    }
    public var accountType:AccountType!
    func fetch()->[TestAccountObject]?{
        let propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        let plistData: [String: AnyObject] = [:] //Our data
        if let stringUrl:String = accountType.stringURL {
            var dicObjects=NSArray.init(contentsOfFile:stringUrl)
            if let  objects:[TestAccountObject]?=dicObjects?.map({ (any:Any) -> TestAccountObject in return TestAccountObject.init(dic: (any as! Dictionary)) }){
            return objects
            }
        }
        
        return []
    }
     public init(_ accountType:AccountType){
        super.init()
        self.accountType=accountType;
    }
     public func show(selectedObject:@escaping (TestAccountObject)->Void){
        let alertViewController:UIAlertController = UIAlertController.init(title:"", message:"", preferredStyle: UIAlertController.Style.actionSheet);
        for object in self.fetch() ?? []{
            alertViewController.addAction(UIAlertAction.init(title:"\(object.accountDescription ?? "") \(object.email ?? "")", style: .default, handler: { (action) in
                selectedObject(object);
            }))
        }
        alertViewController.addAction(UIAlertAction.init(title:"Cancel", style:.cancel, handler: { (alertAction) in
            alertViewController.dismiss(animated: false, completion: nil);
        }))
    (UIApplication.shared.windows.first?.rootViewController as? UIViewController)?.present(alertViewController, animated: true, completion:nil);
    }
}
