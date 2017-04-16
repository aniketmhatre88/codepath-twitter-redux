//
//  TweetCell.swift
//  CodePathTwitterDemo
//
//  Created by Mhatre, Aniket on 4/15/17.
//  Copyright © 2017 Mhatre, Aniket. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user?.name
            timestampLabel.text = "4h"
            tweetTextLabel.text = tweet.text
            
            if let screenName = tweet.user?.screenName {
                screenNameLabel.text = "@\(screenName)"
            }
            
            if let profilePicUrl = tweet.user?.profileUrl {
                profilePic.setImageWith(profilePicUrl)
            }
            
//            if let timestamp = tweet.timestamp {
//                timestamp.compare(<#T##other: Date##Date#>)
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePic.layer.cornerRadius = 4
        profilePic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
