//
//  Posts.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 07/03/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//

import Foundation
import UIKit

class Post: NSObject {
    var sender: String?
    var text: String?
    init(dic:[String: Any]) {
        // email of the user
        sender = dic["sender"] as? String ?? ""
        text = dic["text"] as? String ?? ""

    }
}
