//
//  FriendCell.swift
//  TableViewDemo
//
//  Created by Frank on 15/4/3.
//  Copyright (c) 2015年 bigdata. All rights reserved.
//

import UIKit

class FriendCellView: UITableViewCell {
    
    @IBOutlet weak var ImgAvatars: UIImageView!
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblIntro: UILabel!
    
    var friend: Friend = Friend();

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setFriend(newFriend: Friend) {
        var Image: UIImage? = UIImage(named: "\(newFriend.Avatars)")
        if Image != nil {
            ImgAvatars.image = Image!
        }else{
            ImgAvatars.image = UIImage(named: "user_default")
        }
        LblName.text = newFriend.Name
        LblIntro.text = newFriend.Intro
        if friend.VIP {
            LblName.textColor = UIColor.redColor()
        }else{
            LblName.textColor = UIColor.blackColor()
        }
    }
}
