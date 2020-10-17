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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var contentView: UIView!
    var items:[TestAccountObject]=[TestAccountObject]();
    var list:TestAccountList?
    var fetchType:TestAccountList.FetchType = .direct
    var selectedObject:((TestAccountObject)->Void)?
    open override func layoutSubviews() {
        super.layoutSubviews()

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureXib()
    }
    

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        configureXib()
    }
    class func instanceFromNib() -> AlertView {
        
        let myView = Bundle(for: TestAccountsViewController.self).loadNibNamed("AlertView", owner: nil, options: nil)![0] as! AlertView
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
        list = TestAccountList.init(.development);
        search();
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
       var cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath);
        cell.backgroundView?.backgroundColor=UIColor.clear;
        cell.contentView.backgroundColor=UIColor.clear;

        var object = items[indexPath.row];
        cell.textLabel?.text=object.email;
        return cell;
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var object = items[indexPath.row];
        selectedObject?(object);
        self.list?.saveCoosedItem(object);
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
