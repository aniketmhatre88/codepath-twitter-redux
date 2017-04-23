//
//  ProfileViewController.swift
//  CodePathTwitterDemo
//
//  Created by Mhatre, Aniket on 4/22/17.
//  Copyright © 2017 Mhatre, Aniket. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeTweetDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User.currentUser
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadUserTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
            profileCell.user = user
            return profileCell
        } else {
            let tweetCell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
            tweetCell.tweet = tweets[indexPath.row - 1]
            return tweetCell
        }
    }
    
    func loadUserTweets() {
        TwitterClient.sharedInstance.userTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let navigationController = segue.destination as! UINavigationController
        
        if segue.identifier == "composeSegue" {
            let composeViewController = navigationController.topViewController as! ComposeViewController
            
            let tweet = Tweet()
            tweet.user = User.currentUser
            composeViewController.tweet = tweet
            composeViewController.composeTweetDelegate = self
        }
        
        if segue.identifier == "DetailTweetSegue" {
            let detailTweetViewController = navigationController.topViewController as! DetailTweetViewController
            detailTweetViewController.tweet = sender as! Tweet
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet = tweets[indexPath.row]
        performSegue(withIdentifier: "DetailTweetSegue", sender: tweet)
    }
    
    func onComposeTweet(from tweet: Tweet) {
        tweets.insert(tweet, at: 0)
        tableView.reloadData()
        
        TwitterClient.sharedInstance.tweetStatus(
            tweet: tweet,
            success: { (newTweet: Tweet) in
                loadUserTweets()
        }) { (error: Error?) in
            print(error?.localizedDescription)
        }
    }

    @IBAction func onLogoutButton(_ sender: UIBarButtonItem) {
        TwitterClient.sharedInstance.logout()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
