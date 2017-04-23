//
//  ProfileCell.swift
//  CodePathTwitterDemo
//
//  Created by Mhatre, Aniket on 4/22/17.
//  Copyright © 2017 Mhatre, Aniket. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User! {
        didSet {
            nameLabel.text = user.name
            
            if let screenName = user.screenName {
                screenNameLabel.text = "@\(screenName)"
            }
            
            followersCountLabel.text = String(describing: user.followersCount)
            followingCountLabel.text = String(describing: user.followingCount)
            tweetCountLabel.text = String(describing: user.tweetsCount)
            
            if let profilePicUrl = user.profileUrl {
                profilePicImageView.setImageWith(profilePicUrl)
            }
            
            if let backgroundUrl = user.profileBackgroundUrl {
                profileBackgroundImageView.setImageWith(backgroundUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePicImageView.layer.cornerRadius = 4
        profilePicImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
