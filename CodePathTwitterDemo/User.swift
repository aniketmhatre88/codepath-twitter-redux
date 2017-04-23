//
//  User.swift
//  CodePathTwitterDemo
//
//  Created by Mhatre, Aniket on 4/15/17.
//  Copyright © 2017 Mhatre, Aniket. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var tagline: String?
    var profileBackgroundUrl: URL?
    var tweetsCount: Int = 0
    var followersCount: Int = 0
    var followingCount: Int = 0
    
    var dictionary: NSDictionary?
    
    static var _currentUser: User?
    static let userDidLogoutNotificationName = Notification.Name(rawValue: "UserDidLogout")
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }

        tagline = dictionary["description"] as? String
        
        let backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundUrlString = backgroundUrlString {
            profileBackgroundUrl = URL(string: backgroundUrlString)
        }
        
        if let tweetsCount = dictionary["statuses_count"] as? Int {
            self.tweetsCount = tweetsCount
        }
        
        if let followersCount = dictionary["followers_count"] as? Int {
            self.followersCount = followersCount
        }
        
        if let followingCount = dictionary["following"] as? Int {
            self.followingCount = followingCount
        }
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: []) as Data

                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }

}
