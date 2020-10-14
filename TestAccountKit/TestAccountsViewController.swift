//
//  CountryViewController.swift
//  Concierge
//
//  Created by sondos on 1/20/19.
//  Copyright © 2019 NewLine. All rights reserved.
//

import UIKit

public typealias SelectedHandler = (TestAccountObject)->Void
public typealias BindingHandler = (TestAccountObject,AccountTableViewCell)->Void
public class TestAccountsViewController: UIViewController,UITextFieldDelegate {
  
    var selectedHandler:SelectedHandler?
    var bindingHandler:BindingHandler?
    var fetchType:TestAccountList.FetchType = .direct
    var accountType:TestAccountList.AccountType = .development
    var testAccountList:TestAccountList?
    @IBOutlet weak var tableViewCountry: UITableView!
    private var TestAccountObject : String?
    var countryObj : TestAccountObject?
    var primaryArray: [TestAccountObject] = Array<TestAccountObject>(){
        didSet{
            self.searchArray = primaryArray;
        }
    }
    @IBOutlet weak var txtSearch: UITextField!
    var searchArray:[TestAccountObject] = Array<TestAccountObject>()
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.testAccountList = TestAccountList.init(accountType);
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
        self.primaryArray = testAccountList?.fetch(fetchType:fetchType) ?? []
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
           
        self.searchArray = self.primaryArray.filter(txt:  sender.text!)
        }else{
        self.searchArray = self.primaryArray;
        }
        self.tableViewCountry.reloadData();
    }

    public static func initPicker(_ accountType:TestAccountList.AccountType,fetchType:TestAccountList.FetchType,selectedHandler:@escaping SelectedHandler,bindingHandler:@escaping BindingHandler)->TestAccountsViewController?{
            if let storyboard:UIStoryboard = UIStoryboard.init(name: "TestAccount", bundle:Bundle(for: TestAccountsViewController.self)),
                let vc = storyboard.instantiateViewController(withIdentifier:"TestAccountsViewController") as? TestAccountsViewController{
                vc.accountType=accountType;
                vc.fetchType=fetchType;
                vc.selectedHandler=selectedHandler;
                vc.bindingHandler=bindingHandler;
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
        self.bindingHandler?(object,cell);
        return cell
    }
}

