//
//  PostDataSource.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 07/03/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

class PostDataSource: FUITableViewDataSource {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.count != 0 {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        }
        return Int(self.count)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let noDataLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = "No posts yet - why not add one?"
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = .none
        return 1
    }
}
