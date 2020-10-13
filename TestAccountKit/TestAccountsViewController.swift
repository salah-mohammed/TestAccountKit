//
//  CountryViewController.swift
//  Concierge
//
//  Created by sondos on 1/20/19.
//  Copyright © 2019 NewLine. All rights reserved.
//

import UIKit

public class TestAccountsViewController: UIViewController,UITextFieldDelegate {
    var testAccountManager:TestAccountList?
    public typealias SelectedHandler = (TestAccountObject)->Void
    public var selectedHandler:SelectedHandler?
    @IBOutlet weak var tableViewCountry: UITableView!
    private var TestAccountObject : String?
    var countryObj : TestAccountObject?
    var primaryArray: [TestAccountObject] = [TestAccountObject](){
        didSet{
            self.searchArray = primaryArray;
        }
    }
    var searchArray: [TestAccountObject] = [TestAccountObject]();
    @IBOutlet weak var txtSearch: UITextField!
    override public func viewDidLoad() {
        super.viewDidLoad()

        tableViewCountry.delegate = self
        tableViewCountry.dataSource = self
        getDataFromJSON()
        txtSearch.placeholder = "Search".customLocalize_;
    }
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.view.backgroundColor=UIColor.black.withAlphaComponent(0.4);
    }
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.view.backgroundColor=UIColor.clear;
    }
    func getDataFromJSON(){
//        self.primaryArray =  CountryListManager.shared.getDataFromJSON() ?? []
    }
    
    func search(dial_code : String) {
        
        var row = 0
        for index in 0..<primaryArray.count {
//            if primaryArray[index].dial_code == dial_code {
//                row = index
//                break
//            }
        }
        
        let indexPath = IndexPath(row: row, section: 0)
        tableViewCountry.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)

    }
    
    func alert(msg : String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func txtTxtSearch(_ sender: UITextField) {
        if sender.text?.count ?? 0 != 0 {
        self.searchArray = self.search(text: sender.text!);
        }else{
        self.searchArray = self.primaryArray;
        }
        self.tableViewCountry.reloadData();
    }
    func search(text:String)->[TestAccountObject]{
//       let tempSearchArray = self.primaryArray.filter({ (object) -> Bool in
//        return (object.dial_code?.contains(text) ?? false || object.name?.uppercased().contains(text.uppercased()) ?? false || object.localizeName()?.contains(text) ?? false || object.code?.contains(text) ?? false )
//        });
//        return tempSearchArray;
        return []
    }
        public static func initPicker()->TestAccountsViewController?{
            if let storyboard:UIStoryboard = UIStoryboard.init(name: "TestAccountKit", bundle:Bundle(for: TestAccountsViewController.self)),
                let vc = storyboard.instantiateViewController(withIdentifier:"TestAccountsViewController") as? TestAccountsViewController{

            return vc;
        }
            return nil;
    }
}

extension TestAccountsViewController: UITableViewDelegate {
   
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let countryObject = self.searchArray[indexPath.row]
         selectedHandler?(countryObject)
         self.dismiss(animated: true, completion: nil)
         tableView.deselectRow(at: indexPath, animated: true);
    }
   
}

extension TestAccountsViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as! AccountTableViewCell
        let object = self.searchArray[indexPath.row]
        cell.object = object
        cell.configureCell()

        return cell
    }
}

