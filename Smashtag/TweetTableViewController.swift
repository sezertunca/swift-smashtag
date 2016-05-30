//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Sezer Tunca on 29/05/2016.
//  Copyright © 2016 Sezer Tunca. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController
{
    var tweets = [Array<Tweet>]()
    {
        didSet
        {
            tableView.reloadData()
        }
    }
    
    var searchText: String?
    {
        didSet
        {
            tweets.removeAll()
            searchForTweets()
            title = searchText
        }
    }
    
    private var twitterRequest: TwitterRequest?
    {
        if let query = searchText where !query.isEmpty
        {
            return TwitterRequest(search: query + " -filter:retweets", count: 100)
        }
        
        return nil
    }
    
//    private var lastTwitterRequest: TwitterRequest?
    
    private func searchForTweets()
    {
        if let request = twitterRequest
        {
//            lastTwitterRequest = request
            
            request.fetchTweets { [weak weakSelf = self] newTweets in
                dispatch_async(dispatch_get_main_queue())
                {
//                    if request == weakSelf?.lastTwitterRequest
//                    {
                        if !newTweets.isEmpty
                        {
                            weakSelf?.tweets.insert(newTweets, atIndex: 0)
                        }
//                    }
                }
            }
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchText = "#stanford"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return tweets.count
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tweets[section].count
    }
    
    private struct Storyboard
    {
        static let TweetCellIdentifier = "Tweet"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.TweetCellIdentifier, forIndexPath: indexPath)
        
        let tweet = tweets[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = tweet.user.name
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
