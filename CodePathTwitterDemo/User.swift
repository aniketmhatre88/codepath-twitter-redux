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
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }

        tagline = dictionary["description"] as? String
    }

}
