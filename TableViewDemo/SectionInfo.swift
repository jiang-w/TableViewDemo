//
//  SectionInfo.swift
//  TableViewDemo
//
//  Created by Frank on 15/4/7.
//  Copyright (c) 2015年 bigdata. All rights reserved.
//

import UIKit

class SectionInfo: NSObject {
    var group: Group
    var isOpen: Bool
    var index: Int
    
    init(group: Group, index: Int) {
        self.group = group
        self.isOpen = false
        self.index = index
    }
}
