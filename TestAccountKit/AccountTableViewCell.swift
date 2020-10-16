//
//  AccountTableViewCell.swift
//  TestAccountKit
//
//  Created by Salah on 10/13/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit

public class AccountTableViewCell: UITableViewCell {
    @IBOutlet open weak var lblTitle: UILabel!
    @IBOutlet open weak var lblSubTitle: UILabel!
    var object:TestAccountObject?
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(){
        self.lblTitle.text=object?.username;
        self.lblSubTitle.text=object?.accountDescription;
    }
}
