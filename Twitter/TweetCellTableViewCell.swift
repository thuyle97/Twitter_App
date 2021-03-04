//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Le Thuy on 2/24/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    func setFavorite(_ isFavorite:Bool)
    {
        favorited = isFavorite
        if (favorited)
        {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
        else
        {
            favButton.setImage(UIImage(named: "favor-icon-1"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited)
        {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: {
                (error) in
                print ("Favorite did not succeed: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: {
                (error) in
                print ("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func reTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: {
            (error) in
            print("Error is retweeting: \(error)")
        })

    }
    
    func setRetweeted(_ isRetweeted:Bool)
    {
        if (isRetweeted)
        {
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            reTweetButton.isEnabled = false
        }
        else
        {
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            reTweetButton.isEnabled = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
