//
//  SectionHeaderView.swift
//  TableViewDemo
//
//  Created by Frank on 15/4/7.
//  Copyright (c) 2015年 bigdata. All rights reserved.
//

import UIKit

protocol SectionHeaderViewDelegate: NSObjectProtocol {
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, sectionOpened: Int)
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, sectionClosed: Int)
}

class SectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var BtnDisclosure: UIButton!
    
    var delegate: SectionHeaderViewDelegate?
    var info: SectionInfo!
    
    override func awakeFromNib() {
        // 设置disclosure 按钮的图片（被打开）
        self.BtnDisclosure.setImage(UIImage(named: "carat-open"), forState: UIControlState.Selected)
        // 单击手势识别
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapSectionView:")
        self.addGestureRecognizer(tapGesture)
    }

    func tapSectionView(sender: UITapGestureRecognizer) {
        info.isOpen = !info.isOpen
        BtnDisclosure.selected = info.isOpen
        if delegate != nil {
            if info.isOpen {
                delegate!.sectionHeaderView(self, sectionOpened: info.index)
            }
            else {
                delegate!.sectionHeaderView(self, sectionClosed: info.index)
            }
        }
    }
    
    func setSection(info: SectionInfo) {
        self.info = info
        self.LblTitle.text = info.group.name
        self.BtnDisclosure.selected = info.isOpen
    }
}
