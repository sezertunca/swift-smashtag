//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Sezer Tunca on 30/05/2016.
//  Copyright © 2016 Sezer Tunca. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreateTimeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    
    var tweet: Tweet?
    {
        didSet
        {
            updateUI()
        }
    }
    
    private func updateUI()
    {
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreateTimeLabel?.text = nil
        
        if let tweet = self.tweet
        {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel.text != nil
            {
                for _ in tweet.media
                {
                    tweetTextLabel.text! += " 📸"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL
            {
                if let imageData = NSData(contentsOfURL: profileImageURL) // blocks main thread 
                {
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60
            {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            }
            else
            {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            
            tweetCreateTimeLabel?.text = formatter.stringFromDate(tweet.created)
        }
        
    }
}
