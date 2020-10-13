//
//  AccountTableViewCell.swift
//  TestAccountKit
//
//  Created by Salah on 10/13/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    var object:TestAccountObject?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(){
        
    }
}
