//
//  PostsTableViewCell.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 15/04/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    @IBOutlet weak var postCellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(post:Post){
        if let sender = post.sender, let body = post.text{
            postCellLabel.text = "\(sender)\n\(body)"
        }
    }

}
