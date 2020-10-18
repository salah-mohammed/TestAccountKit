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
        return NSLocalizedString(self, tableName: nil, bundle:Bundle(for: TestAccountObject.self) ?? Bundle.main, value: "", comment: "")
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
