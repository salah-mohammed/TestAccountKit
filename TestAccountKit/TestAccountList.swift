//
//  TestAccountList.swift
//  Masterly
//
//  Created by Salah on 12/10/19.
//  Copyright © 2019 Newline. All rights reserved.
//

import UIKit
import Foundation
extension Sequence where Iterator.Element == TestAccountObject
{
    // ...
    var lastOrder:Int{
       var items =  self.sorted { (first, second) -> Bool in
       return first.order ?? 0 > second.order ?? 0 }
        return items.last?.order ?? 0;
    }
    func filter(txt:String)->[TestAccountObject]{      
    return self.filter { (item) -> Bool in
              return item.id?.contains(txt) ?? false || item.email?.contains(txt) ?? false ||  item.username?.contains(txt) ?? false || item.accountDescription?.contains(txt) ?? false
          }
    }
}
extension UserDefaults{
    static func setLastChoosedArray(values:[String],key:String){
        UserDefaults.standard.set(values, forKey:key)
    }
    static func getLastChoosedArray(key:String)->[String]{
     return UserDefaults.standard.stringArray(forKey:key) ?? []
    }
}

public class TestAccountList: NSObject {
    public enum FetchType{
    case direct
    case inDirect
    }
    var lastChooseKey:String{
        switch self.accountType {
        case .development:
            return "TestAccountListDevelopment.json";
        case .producation:
            return "TestAccountListProducation.json";
        case .plistName(let plistName):
            return "";
        case .plistStringURL(let url):
            return "";
        case .none:
            
            return "";
        }
    }
    var lastChooseArray:[String]{
        set{
            UserDefaults.setLastChoosedArray(values:lastChooseArray, key:lastChooseKey ?? "")
        }
        get{
            return UserDefaults.getLastChoosedArray(key:lastChooseKey ?? "");
        }
    }
    
    public enum AccountType{
    case development // You should set plist with this name "TestAccountListDevelopment.plist"
    case producation // You should set plist with this name "TestAccountListProducation.plist"
    case plistName(String) // plist name only with any extension
    case plistStringURL(String)

    var stringURL:String?{
            switch self {
            case .development:
                return TestAccountList.toStringURL(plistName:"TestAccountListDevelopment");
            case .producation:
                return TestAccountList.toStringURL(plistName:"TestAccountListProducation");
            case .plistName(let plistName):
                return TestAccountList.toStringURL(plistName:plistName);
            case .plistStringURL(let url):
                return url;
            }
            return nil;
        }
    }
    static func toStringURL(plistName:String)->String?{
     return Bundle.main.path(forResource:plistName, ofType: "plist")
    }
    public var accountType:AccountType!
    private func fetchInDirect()->[TestAccountObject]?{
        let propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        let plistData: [String: AnyObject] = [:] //Our data
        if var  objects:[TestAccountObject]?=self.loaddSavedObjects(key:self.lastChooseKey){
            return objects
            }
        return []
    }
    open func fetch(fetchType:FetchType)->[TestAccountObject]?{
        switch fetchType {
        case .direct:
            return self.fetchDirect()
        case .inDirect:
            return self.fetchInDirect();
        }
        return []
    }
   private func fetchDirect()->[TestAccountObject]?{
        let propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        let plistData: [String: AnyObject] = [:] //Our data
        if let stringUrl:String = accountType.stringURL {
            var dicObjects=NSArray.init(contentsOfFile:stringUrl)
            if var  objects:[TestAccountObject]?=dicObjects?.map({ (any:Any) -> TestAccountObject in return TestAccountObject.init(dic: (any as! Dictionary)) }){
                //loadd
            return objects
            }
        }
        
        return []
    }
     public init(_ accountType:AccountType){
        super.init()
        self.accountType=accountType;
        update();
    }
    public func showAsAlert(_ fetchType:FetchType, _ title:((TestAccountObject)->String)? = nil,selectedObject:@escaping (TestAccountObject)->Void){
        let alertViewController:UIAlertController = UIAlertController.init(title:"", message:"", preferredStyle: UIAlertController.Style.actionSheet);
        for object in self.fetch(fetchType:fetchType) ?? []{
            alertViewController.addAction(UIAlertAction.init(title:title?(object) ?? "(\(object.accountDescription ?? "")) \(object.email ?? "")", style: .default, handler: { (action) in
                selectedObject(object);
                self.saveCoosedItem(object);
            }))
        }
        alertViewController.addAction(UIAlertAction.init(title:"Cancel", style:.cancel, handler: { (alertAction) in
            alertViewController.dismiss(animated: false, completion: nil);
        }))
    (UIApplication.shared.windows.first?.rootViewController as? UIViewController)?.present(alertViewController, animated: true, completion:nil);
    }

}


extension TestAccountList{
    func savedListURL(key:String)->URL?{
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(key)
        return fileURL;
        }
        return nil;
    }
    func saveCoosedItem(_ item:TestAccountObject){
        var saved = self.loaddSavedObjects(key: self.lastChooseKey)

        saved.removeAll { (object) -> Bool in
            return item.isEqual(object)
        }
        item.order = saved.lastOrder + 1;
        saved.append(item)
        self.write(savedObjects: saved, key: self.lastChooseKey);
    }
    func loaddSavedObjects(key:String)->[TestAccountObject]{
        return self.loadd(key:key)?.map({ (item) -> TestAccountObject in
            return TestAccountObject.init(dic: item);
        }) ?? []
    }
    func loadd(key:String)->[[String:Any]]?{
          do {
             if let fileURL = self.savedListURL(key: key){
                 let data:Data = try Data.init(contentsOf: fileURL)
                 do {
                          return try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, Any>]
                      } catch {
                          print(error.localizedDescription)
                      }
             }
          }
          catch {/* error handling here */}
         return nil;
     }
     func write(savedObjects:[TestAccountObject],key:String){
         var dicItems = savedObjects.map { (item) -> [String:Any] in
             return (item.dic ?? [:])
         }
         self.write(saved: dicItems, key: key)
     }
     func write(saved:[Dictionary<String, Any>],key:String){
         var content = saved.json;
         if let fileURL = self.savedListURL(key:key){
         do {
         try content.write(to: fileURL, atomically: false, encoding:String.Encoding.utf8.rawValue)
         }
        catch {/* error handling here */}

         }
     }
    func update(){
        var inDirectObjects = self.fetchInDirect();
        var directObjects = self.fetchDirect()
        
        if inDirectObjects?.count == 0 {
            inDirectObjects=directObjects;
        }else{
        // when update data
        for item in directObjects ?? []{
            // when add new item
            if inDirectObjects?.contains(item) == false {
            inDirectObjects?.append(item)
            }
        }
        for item in inDirectObjects ?? []{
            // when remove item
            if directObjects?.contains(item) == false {
                inDirectObjects?.removeAll(where: { (item) -> Bool in
                    item == item
                });
            }
        }
        }
        self.write(savedObjects: inDirectObjects ?? [], key: self.lastChooseKey)
    }
    open func clear(){
        let inDirectObjects = self.fetchInDirect();
        self.write(savedObjects: inDirectObjects ?? [], key: self.lastChooseKey)
    }
}
