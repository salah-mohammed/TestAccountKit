//
//  PhoneKitEx.swift
//  LocationPicker
//
//  Created by Salah on 5/28/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import Foundation
import UIKit
extension Bundle{

}
extension String{
     var customLocalize_ : String {
        return NSLocalizedString(self, tableName: nil, bundle:FrameWorkConstants.frameWorkBundle ?? Bundle.main, value: "", comment: "")
    }
     func bs_replace(target: String, withString: String) -> String {
        
        return self.replacingOccurrences(of: target, with:withString, options: .literal, range: nil)
    }
     func bs_arNumberToEn()-> String {
        let numbersDictionary : Dictionary = ["٠" : "0","١" : "1", "٢" : "2", "٣" : "3", "٤" : "4", "٥" : "5", "٦" : "6", "٧" : "7", "٨" : "8", "٩" : "9"]
        var str : String = self
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        return str
    }
}
extension UIViewController{
     func bs_showMessageWithTitle(title:String,message:String?)
     {
         let alert = UIAlertController(title:title, message:message, preferredStyle:UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "تم", style:UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
}
extension String {
    func fileName() -> String {
        return URL(fileURLWithPath: self).fileName();
    }

    func fileExtension() -> String {
        return URL(fileURLWithPath: self).fileExtension();
    }
}
extension URL {
    func fileName() -> String {
        return self.deletingPathExtension().lastPathComponent
    }

    func fileExtension() -> String {
        return self.pathExtension
    }
}
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension FileManager{
    func createFolder(_ documentDirectory:SearchPathDirectory = .documentDirectory,folderName: String) -> URL? {
            let fileManager = FileManager.default
            // Get document directory for device, this should succeed
            if let documentDirectory = fileManager.urls(for:documentDirectory,
                                                        in: .userDomainMask).first {
                // Construct a URL with desired folder name
                let folderURL = documentDirectory.appendingPathComponent(folderName)
                // If folder URL does not exist, create it
                if !fileManager.fileExists(atPath: folderURL.path) {
                    do {
                        // Attempt to create folder
                        try fileManager.createDirectory(atPath: folderURL.path,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
                    } catch {
                        // Creation failed. Print error & return nil
                        print(error.localizedDescription)
                        return nil
                    }
                }
                // Folder either exists, or was created. Return URL
                return folderURL
            }
            // Will only be called if document directory not found
            return nil
        }
}

////// Business
extension Sequence where Iterator.Element == TestAccountObject
{
    // ...
    var lastOrder:Int{
       var items =  self.sorted { (first, second) -> Bool in
       return first.order ?? 0 < second.order ?? 0 }
        return items.last?.order ?? 0;
    }
    func filter(txt:String)->[TestAccountObject]{
    return self.filter { (item) -> Bool in
              return item.id?.contains(txt) ?? false || item.email?.contains(txt) ?? false ||  item.username?.contains(txt) ?? false || item.accountDescription?.contains(txt) ?? false
          }
    }
    func isContains(_ object:TestAccountObject)->Bool{
        var item = self.filter { (item) -> Bool in
        return object.isEqual(item)};
        return item.count != 0
    }
    func isUpdated(_ object:TestAccountObject)->TestAccountObject?{
        var item = self.filter { (item) -> Bool in
            return object.isUpdated(item)}.first;
        return item
    }
}
extension UserDefaults{
    var savedBuildVersion:String?{
        set{
            UserDefaults.standard.set(newValue, forKey:"SavedBuildVersion")
        }
        get{
            return UserDefaults.standard.value(forKey:"SavedBuildVersion") as? String
        }
    }
}

extension UIAlertController{
    
    public static func show(_ accountType:TestAccountList.AccountType ,
                            _ fetchType:TestAccountList.FetchType,
                            _ title:TitleHandler? = nil,
                            selectedHandler:SelectedHandler?){
            let alertController:UIAlertController = UIAlertController.init(title:"\n\n\n\n\n\n\n\n\n\n\n\n", message:"\n\n\n\n\n", preferredStyle: UIAlertController.Style.actionSheet);
        FrameWorkConstants.frameWorkBundle = Bundle.framwWorkBundle;
        var customView = AlertView.instanceFromNib();
        customView.update(accountType, fetchType, title, selectedHandler,alertController);
        let parent = alertController.view.subviews[0].subviews[0];
        parent.addSubview(customView)
        
        customView.translatesAutoresizingMaskIntoConstraints = false

        parent.addConstraint(NSLayoutConstraint(item: customView, attribute: .trailing, relatedBy: .equal, toItem: parent, attribute: .trailing, multiplier: 1, constant: 0))
        parent.addConstraint(NSLayoutConstraint(item: customView, attribute: .leading, relatedBy: .equal, toItem: parent, attribute: .leading, multiplier: 1, constant: 0))
        parent.addConstraint(NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1, constant: 0))
        parent.addConstraint(NSLayoutConstraint(item: customView, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1, constant: 0))
        
            alertController.addAction(UIAlertAction.init(title:"Cancel".customLocalize_, style:.cancel, handler: { (alertAction) in
                alertController.dismiss(animated: false, completion: nil);
            }))
        (UIApplication.shared.windows.first?.rootViewController as? UIViewController)?.present(alertController, animated: true, completion:{
        });
        }
}

extension Bundle{
    class var framwWorkBundle:Bundle?{
        let podBundle = Bundle(for: TestAccountsViewController.self)
        if let bundleURL:URL = podBundle.url(forResource: "TestAccount", withExtension: "storyboard"){
        return Bundle(url: bundleURL)
        }
        return nil;
    }
}
