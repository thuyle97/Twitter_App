//
//  TweetViewController.swift
//  Twitter
//
//  Created by Le Thuy on 3/3/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
        // Add border to the text view
        let borderColor : UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        tweetTextView.layer.borderWidth = 1.0
        tweetTextView.layer.borderColor = borderColor.cgColor
        tweetTextView.layer.cornerRadius = 5.0
        
        tweetTextView.delegate = self
        
    }
    
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       // TODO: Check the proposed new text character count
       // Allow or disallow the new text
        
        var characterLimit:Int = 280
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        
        characterLimit = characterLimit - newText.count
        
        countLable.text = "\(characterLimit)"
        
        return newText.count < characterLimit
    }

    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty)
        {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {self.dismiss(animated: true, completion: nil)}, failure: {(error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
