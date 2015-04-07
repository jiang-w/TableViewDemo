//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Frank on 15/4/3.
//  Copyright (c) 2015年 bigdata. All rights reserved.
//

import UIKit

class FriendListView: UITableViewController, SectionHeaderViewDelegate {
    
    var sectionInfoArray: [SectionInfo]!
    let SectionHeaderViewIdentifier = "SectionHeaderViewIdentifier"
    let FriendCellIdentifier = "FriendCellIdentifier"
    let HeaderHeight: CGFloat = 40

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var index = 0
        sectionInfoArray = loadFriendList().map({ SectionInfo(group: $0, index: index++) });
        let sectionHeaderNib: UINib = UINib(nibName: "SectionHeaderView", bundle: nil)
        self.tableView.registerNib(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: SectionHeaderViewIdentifier)
        self.tableView.sectionHeaderHeight = HeaderHeight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionInfoArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sectionInfo = sectionInfoArray[section]
        if sectionInfo.isOpen {
            return sectionInfo.group.friends.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sectionInfo = sectionInfoArray[section]
        var sectionHeaderView: SectionHeaderView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(SectionHeaderViewIdentifier) as SectionHeaderView
        sectionHeaderView.setSection(sectionInfo)
        sectionHeaderView.delegate = self
        return sectionHeaderView
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(FriendCellIdentifier) as FriendCellView
        var friend = sectionInfoArray[indexPath.section].group.friends[indexPath.row]
        cell.setFriend(friend)
        return cell
    }
 
    func loadFriendList() -> [Group] {
        var list: [Group] = []
        var fileUrl = NSBundle.mainBundle().URLForResource("FriendList", withExtension: "plist")
        var groupArray = NSArray(contentsOfURL: fileUrl!) as [NSDictionary]
        for groupDic in groupArray {
            var group = Group()
            group.name = groupDic["GroupName"] as String
            var friendArray = groupDic["Friends"] as [NSDictionary]
            for friendDic in friendArray {
                var friend = Friend()
                friend.setValuesForKeysWithDictionary(friendDic)
                group.friends.append(friend)
            }
            list.append(group)
        }
        return list
    }
    
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, sectionOpened: Int) {
        var sectionInfo = sectionInfoArray[sectionOpened] as SectionInfo
        //创建一个包含单元格索引路径的数组来实现插入单元格的操作：这些路径对应当前节的每个单元格
        var countOfRowsToInsert = sectionInfo.group.friends.count
        var indexPathsToInsert = [NSIndexPath]()
        for (var i = 0; i < countOfRowsToInsert; i++) {
            indexPathsToInsert.append(NSIndexPath(forRow: i, inSection: sectionOpened))
        }
        self.tableView.insertRowsAtIndexPaths(indexPathsToInsert, withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, sectionClosed: Int) {
        var sectionInfo = self.sectionInfoArray[sectionClosed] as SectionInfo
        var countOfRowsToDelete = self.tableView.numberOfRowsInSection(sectionClosed)
        if countOfRowsToDelete > 0 {
            var indexPathsToDelete = [NSIndexPath]()
            for (var i = 0; i < countOfRowsToDelete; i++) {
                indexPathsToDelete.append(NSIndexPath(forRow: i, inSection: sectionClosed))
            }
            self.tableView.deleteRowsAtIndexPaths(indexPathsToDelete, withRowAnimation: UITableViewRowAnimation.None)
        }
    }
}

