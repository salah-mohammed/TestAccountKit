//
//  FloatButtonView.swift
//  tesdasdasd
//
//  Created by SalahMohammed on 8/30/20.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit


open class AlertView: UIView {
     @IBOutlet open weak var layoutConstraintHeightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var contentView: UIView!
    var alertController:UIAlertController?
    var items:[TestAccountObject]=[TestAccountObject]();
    var list:TestAccountList?
    var fetchType:TestAccountList.FetchType = .direct
    var accountType:TestAccountList.AccountType = .development;
    var selectedHandler:SelectedHandler?
    var titleHandler:TitleHandler?
    open override func layoutSubviews() {
        super.layoutSubviews()

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureXib()
    }
    func update(_ accountType:TestAccountList.AccountType,
                _ fetchType:TestAccountList.FetchType,
                _ titleHandler:TitleHandler?,
                _ selectedHandler:SelectedHandler?,
                _ alertController:UIAlertController?){
        self.accountType=accountType;
        self.titleHandler=titleHandler;
        self.selectedHandler=selectedHandler
        self.fetchType=fetchType;
        self.alertController=alertController;
        list = TestAccountList.init(self.accountType);
        search();
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        configureXib()
    }
    class func instanceFromNib() -> AlertView {
        
        let myView = FrameWorkConstants.frameWorkBundle?.loadNibNamed("AlertView", owner: nil, options: nil)![0] as! AlertView
        myView.configureXib()
        return myView;
        
    }
    private func configureXib() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchBar.backgroundColor=UIColor.clear;
        searchBar.barTintColor=UIColor.clear;
        searchBar.setSearchFieldBackgroundImage(nil, for: .normal);
        searchBar.searchBarStyle = .minimal
        searchBar.delegate=self;
        tableView.delegate=self;
        tableView.dataSource=self;
        layoutConstraintHeightOfTableView.constant = UIScreen.main.bounds.height*0.6;
        self.searchBar.autocapitalizationType = .none;
        self.searchBar.placeholder="Search".customLocalize_;
    }
    func search(){
        if self.searchBar.text?.count == 0 {
        self.items = self.list?.fetch(fetchType:fetchType) ?? [];
        }else{
        self.items = self.list?.fetch(fetchType:fetchType)?.filter(txt: self.searchBar.text ?? "") ?? []
        }
        self.tableView.reloadData();
    }
}
extension AlertView:UITableViewDelegate,UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath);
        cell.contentView.backgroundColor=UIColor.clear;
        cell.backgroundColor=UIColor.clear;

        var object = items[indexPath.row];
        cell.textLabel?.text=titleHandler?(object) ?? object.email;
        cell.textLabel?.textAlignment = .center;
        cell.textLabel?.textColor=UIColor.systemBlue;
        cell.textLabel?.font=UIFont.systemFont(ofSize: 19, weight: .regular);
        return cell;
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var object = items[indexPath.row];
        selectedHandler?(object);
        self.list?.saveCoosedItem(object);
        self.alertController?.dismiss(animated: true, completion: nil);
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50;
    }
}
extension AlertView:UISearchBarDelegate{
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search();
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.search();
    }
}
