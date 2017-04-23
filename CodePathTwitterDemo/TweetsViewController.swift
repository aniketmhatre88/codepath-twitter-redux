//
//  TweetsViewController.swift
//  CodePathTwitterDemo
//
//  Created by Mhatre, Aniket on 4/15/17.
//  Copyright © 2017 Mhatre, Aniket. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeTweetDelegate {
    
    var tweets: [Tweet] = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogOutButton(_ sender: UIBarButtonItem) {
        TwitterClient.sharedInstance.logout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        loadHomeTimeline(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onProfilePicTap(sender:)))
        
        let profilePicView = cell.profilePic
        profilePicView?.isUserInteractionEnabled = true
        profilePicView?.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    func loadHomeTimeline(_ refreshControl: UIRefreshControl?) {
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl?.endRefreshing()
            
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadHomeTimeline(refreshControl)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
        
        if segue.identifier == "profileSegue" {
            let tapGesture = sender as! UITapGestureRecognizer
            let tableCell = tapGesture.view?.superview?.superview as! TweetCell
            let indexPath = tableView.indexPath(for: tableCell)
            let tweet = tweets[indexPath!.row]
            
            let profileViewController = navigationController.topViewController as! ProfileViewController
            profileViewController.user = tweet.user
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
                loadHomeTimeline(nil)
        }) { (error: Error?) in
            print(error?.localizedDescription)
        }
    }
    
    func onProfilePicTap(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profileSegue", sender: sender)
    }
}
