//
//  dictionaryExtension.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 15/04/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//

import Foundation
extension Dictionary {
    public init(keyValuePairs: [(Key, Value)]) {
        self.init()
        for pair in keyValuePairs {
            self[pair.0] = pair.1
        }
    }
}
