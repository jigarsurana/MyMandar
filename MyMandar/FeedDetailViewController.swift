//
//  FeedDetailViewController.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/12/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {
    var feedData:Feed!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var uploadedByLabel: UILabel!
    @IBOutlet weak var uploadDateLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleLabel.text = feedData.feed_title
        self.descriptionLabel.text = feedData.feed_text
        self.uploadedByLabel.text = feedData.uploaded_by
        self.uploadDateLabel.text = feedData.upload_date
        
        var url:NSURL = NSURL(string: feedData.feed_image)!
        var data:NSData = NSData(contentsOfURL: url, options: nil, error: nil)!
        self.feedImageView.image = UIImage(data: data)
        self.feedImageView.tintColor = UIColor.blackColor()
        //        let overlay:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.feedImageView.frame.size.width, height: self.feedImageView.frame.size.height / 2))
//        
//        [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
//        [myImageView addSubview:overlay];

//        self.feedImageView.layer.cornerRadius = self.feedImageView.frame.size.width / 2;
//        self.feedImageView.clipsToBounds = true;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goBackToFeedView(sender: AnyObject) {
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
