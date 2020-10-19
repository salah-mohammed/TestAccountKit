//
//  TestAccountObject.swift
//  Masterly
//
//  Created by Salah on 12/10/19.
//  Copyright © 2019 Newline. All rights reserved.
//

import UIKit

public class TestAccountObject: NSObject {
    var dic:[String:Any]?
    open var id:String?;
    open var accountDescription:String?
    open var username:String?;
    open var email:String?;
    open var phoneNumber:String?;
    open var password:String?;
    open var other:String?;
    open var order:Int?{
        didSet{
            dic?["order"] = order
        }
    }
    public override init() {
        super.init();
    }
     init(dic:[String:Any]) {
        super.init()
        self.dic=dic;
        self.id = dic["id"] as? String
        self.accountDescription = dic["accountDescription"] as? String
        self.username = dic["username"] as? String
        self.email = dic["email"] as? String
        self.phoneNumber = dic["phoneNumber"] as? String
        self.password = dic["password"] as? String
        self.other = dic["other"] as? String
        self.order = dic["order"] as? Int

        
    }
     func isEqual(_ object: TestAccountObject?) -> Bool{
        if object?.id == nil || self.id == nil {
        return false;
        }else
        if  self.id==object?.id{
        return true;
        }
        return false
     }
    func isEqualDic(_ dictionary: [String:Any]?)->Bool{
        var did = dictionary?["id"] as? String
        var daccountDescription = dictionary?["accountDescription"] as? String
        var dusername = dictionary?["username"] as? String
        var demail = dictionary?["email"] as? String
        var dphoneNumber = dictionary?["phoneNumber"] as? String
        var dpassword = dictionary?["password"] as? String
        var dother = dictionary?["other"] as? String
//        if  self.id==did &&
//            self.accountDescription==daccountDescription &&
//            self.username==dusername &&
//            self.email==demail &&
//            self.phoneNumber==phoneNumber &&
//            self.password==password &&
//            self.other==other{
//            return true;
//        }
        if  self.id==did{
            return true;
        }
        return false;
    }
    func update(newObject:TestAccountObject){
        self.accountDescription=newObject.accountDescription
        self.username=newObject.username
        self.email=newObject.email
        self.phoneNumber=newObject.phoneNumber;
        self.password=newObject.password;
        self.other=newObject.other;
        dic?["accountDescription"]=accountDescription
        dic?["username"]=username
        dic?["email"]=email
        dic?["phoneNumber"]=phoneNumber
        dic?["password"]=password
        dic?["other"]=other

    }
    func isUpdated(_ newObject:TestAccountObject)->Bool{
        if newObject.id == nil && self.id == nil {
            return false;
        }else
        if (newObject.id == self.id){
            if accountDescription != newObject.accountDescription ||
             username != newObject.username ||
             email != newObject.email ||
             phoneNumber != newObject.phoneNumber ||
             password != newObject.password ||
             other != newObject.other {
                return true;
            }
        }
        return false
    }
}
extension Dictionary{
    func json()->NSString{
        let jsonData = try! JSONSerialization.data(withJSONObject: self)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        return jsonString ?? ""
    }
}
extension Array where Element == Dictionary<String, Any> {
    var json: NSString {
        do {
            if let jsonData:Data = try? JSONSerialization.data(withJSONObject: self){
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            return jsonString ?? ""
            }else{
            return "[]"
            }
    }
}
}
