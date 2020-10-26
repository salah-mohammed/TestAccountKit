//
//  TestAccountList.swift
//  Masterly
//
//  Created by Salah on 12/10/19.
//  Copyright © 2019 Newline. All rights reserved.
//

import UIKit
import Foundation
let BuildVersion = Bundle(for: TestAccountObject.self).buildVersionNumber

public typealias SelectedHandler = (TestAccountObject)->Void
public typealias BindingHandler = (TestAccountObject,AccountTableViewCell)->Void
public typealias TitleHandler = ((TestAccountObject)->String)

public class TestAccountList: NSObject {
    let folderName:String="TestAccountKit";
    var folderURL:URL?{
        if var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        dir = dir.appendingPathComponent(folderName)
            return dir;
        }
       return nil
    }

    public enum FetchType{
    case direct
    case inDirect
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
    open func fetch(fetchType:FetchType)->[TestAccountObject]?{
        switch fetchType {
        case .direct:
            return self.fetchDirect()
        case .inDirect:
            var a = self.fetchInDirect()?.sorted(by: { (first, second) -> Bool in
                return first.order ?? -1 > second.order ?? -1
            });
            return a
        }
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
        setup();
        update();
        buildVersionUpdate();
    }
    func setup(){
        let tempLocalFolderUrl:URL? = FileManager.default.createFolder(folderName:self.folderName);
    }
    private func showAsAlert(_ fetchType:FetchType, _ title:((TestAccountObject)->String)? = nil,selectedObject:@escaping (TestAccountObject)->Void){
        let alertViewController:UIAlertController = UIAlertController.init(title:"ChooseAccount".customLocalize_, message:"Choose".customLocalize_, preferredStyle: UIAlertController.Style.actionSheet);
        
        for object in self.fetch(fetchType:fetchType) ?? []{
            alertViewController.addAction(UIAlertAction.init(title:title?(object) ?? "(\(object.accountDescription ?? "")) \(object.email ?? "")", style: .default, handler: { (action) in
                selectedObject(object);
                self.saveCoosedItem(object);
            }))
        }
        alertViewController.addAction(UIAlertAction.init(title:"Cancel".customLocalize_, style:.cancel, handler: { (alertAction) in
            alertViewController.dismiss(animated: false, completion: nil);
        }))
    (UIApplication.shared.windows.first?.rootViewController as? UIViewController)?.present(alertViewController, animated: true, completion:{
    });
    }

}
extension TestAccountList{
    func buildVersionUpdate(){
        if UserDefaults.standard.savedBuildVersion == nil {
            // first time use
            UserDefaults.standard.savedBuildVersion=BuildVersion
        }else{
            if let savedBuildVersion:String = UserDefaults.standard.savedBuildVersion,
                let BuildVersion:String = BuildVersion {
                if BuildVersion != savedBuildVersion {
                    switch BuildVersion{
                    case "0.1.2":
                    print("0.1.2");
                    break;
                    default:
                    break;
                }
                self.clear();
                UserDefaults.standard.savedBuildVersion=BuildVersion
                }
            }
        }
    }
    var lastChooseKey:String{
        switch self.accountType {
        case .development:
            return "TestAccountListDevelopment.json";
        case .producation:
            return "TestAccountListProducation.json";
        case .plistName(let plistName):
            return "\(plistName.fileName()).\(plistName.fileExtension())";
        case .plistStringURL(let url):
            return "\(url.fileName()).json";
        case .none:
            
            return "";
        }
    }
    private func fetchInDirect()->[TestAccountObject]?{
        let propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        if var  objects:[TestAccountObject]?=self.loaddSavedObjects(key:self.lastChooseKey){
            return objects
            }
        return []
    }
    func savedListURL(key:String)->URL?{
        if let dir = folderURL{
        let fileURL = dir.appendingPathComponent(key)
        return fileURL;
        }
        return nil;
    }
    open func saveCoosedItem(_ item:TestAccountObject){
        var saved = self.loaddSavedObjects(key: self.lastChooseKey)
        let beforeRemove = saved.count;
        saved.removeAll { (object) -> Bool in
            return object.isEqual(item)
        }
        let afterRemove = saved.count;
        if beforeRemove != afterRemove {
        item.order = saved.lastOrder + 1;
        saved.append(item)
        self.write(savedObjects: saved, key: self.lastChooseKey);
        }
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
        let directObjects = self.fetchDirect()
        
        if inDirectObjects?.count == 0 {
            inDirectObjects=directObjects;
        }else
        if let item:TestAccountObject=inDirectObjects?.filter({ (item) -> Bool in
             return item.id == nil
         }).first{
            inDirectObjects=directObjects;
         }
        else{
        // when update data
        for directObject in directObjects ?? []{
            // when add new item
            if inDirectObjects?.isContains(directObject) == false {
            inDirectObjects?.append(directObject)
            }
            if let internalItem:TestAccountObject = inDirectObjects?.isUpdated(directObject){
                internalItem.update(newObject:directObject);
            }
        }
        for inDirectObject in inDirectObjects ?? []{
            // when remove item
            if directObjects?.isContains(inDirectObject) == false {
                inDirectObjects?.removeAll(where: { (item) -> Bool in
                    inDirectObject.id == item.id
                });
            }
        }
        }
        self.write(savedObjects: inDirectObjects ?? [], key: self.lastChooseKey)
    }
    // use for indirect only
    open func clear(){
        do {
            if let folderURL:URL=folderURL{
            // Check if file exists
                if FileManager.default.fileExists(atPath:folderURL.path) {
                // Delete file
                try? FileManager.default.removeItem(at:folderURL);
            } else {
                print("File does not exist")
            }
        }
        }
        let tempLocalFolderUrl:URL? = FileManager.default.createFolder(folderName:self.folderName);
        let inDirectObjects = self.fetchInDirect();
        self.write(savedObjects: inDirectObjects ?? [], key: self.lastChooseKey)
    }
}
