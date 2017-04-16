//
//  Tweet.swift
//  CodePathTwitterDemo
//
//  Created by Mhatre, Aniket on 4/15/17.
//  Copyright © 2017 Mhatre, Aniket. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favouritesCount: Int = 0
    var user: User?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        
        let dateString = dictionary["created_at"] as? String
        
        if let dateString = dateString {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            timestamp = dateFormatter.date(from: dateString)
        }

        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        if let userDictionary = dictionary["user"] as? NSDictionary {
            user = User(dictionary: userDictionary)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
