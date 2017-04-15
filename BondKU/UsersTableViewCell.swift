//
//  UsersTableViewCell.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 15/04/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpCell(user:UserDatabase){
        if let fname = user.userFName , let lName = user.userLName{
        userCellLabel.text = "\(fname) + \(lName)"
        }
        
    }

}
