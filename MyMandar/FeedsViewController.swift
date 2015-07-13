//
//  FeedsViewController.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/11/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feedSearchBar: UISearchBar!

    var items: [String] = ["We", "Heart", "Swift"]
    var feeds = [Feed]()
    var filteredFeeds = [Feed]()
    var refreshControl : UIRefreshControl!

    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllFeeds()
        feedSearchBar.delegate = self
        // Do any additional setup after loading the view.
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to get latest updates")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    
    }

    func refresh(sender:AnyObject) {
        self.getAllFeeds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getAllFeeds() {
        let feedMapping = RKObjectMapping(forClass: Feed.self)
        feedMapping.addAttributeMappingsFromArray(["feed_image","feed_title","feed_text","uploaded_by","upload_date"])
        
        let responseDescriptor = RKResponseDescriptor(mapping: feedMapping, method: RKRequestMethod.GET, pathPattern: nil, keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful))
        
        let urlPath = GlobalConstants.BASE_API_URL + "feed/all"
        let urlReq = NSURLRequest(URL: NSURL(string: urlPath)!)
        
        let req = RKObjectRequestOperation(request: urlReq, responseDescriptors: [responseDescriptor!])
        req.setCompletionBlockWithSuccess({ operation, result in
            self.feeds.removeAll(keepCapacity: false)
            var feedsArray: NSArray = result.array();
            for feed in feedsArray {
                var  f: Feed = feed as! Feed;
                self.feeds.append(f)
            }
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, failure: { operation , error in
                
                println("error is " )
        })
        req.start()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return self.filteredFeeds.count
        }else {
            return self.feeds.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BigTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! BigTableViewCell
        var feed:Feed!
        if(searchActive) {
            feed = self.filteredFeeds[indexPath.row]
        } else {
            feed = self.feeds[indexPath.row]
        }
        println(feed.feed_image)
        var url:NSURL = NSURL(string: feed.feed_image)!
        var data:NSData = NSData(contentsOfURL: url, options: nil, error: nil)!
        cell.feedImageView.image = UIImage(data: data)
        cell.feedImageView.layer.cornerRadius = cell.feedImageView.frame.size.width / 2;
        cell.feedImageView.clipsToBounds = true;
//        setFeedCellConstraints(cell)
        
        cell.titleLabel.text = feed.feed_title
        cell.uploadedByLabel.text = "- " + feed.uploaded_by
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //#search control pragma
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        filteredFeeds = feeds.filter({ (feed) -> Bool in
            let tmp: NSString = feed.feed_text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filteredFeeds.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    func setFeedCellConstraints(cell: BigTableViewCell) {
        //Title
        var c1 = NSLayoutConstraint(item: cell.titleLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1, constant: 5)
        var c2 = NSLayoutConstraint(item: cell.titleLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 5)
        var c3 = NSLayoutConstraint(item: cell.titleLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 300)
        var c4 = NSLayoutConstraint(item: cell.titleLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: cell.uploadedByLabel, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)

        //uploaded by
        var c5 = NSLayoutConstraint(item: cell.uploadedByLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: cell, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1, constant: 5)
        var c6 = NSLayoutConstraint(item: cell.uploadedByLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: cell, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 10)
//        var c7 = NSLayoutConstraint(item: cell.uploadedByLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: cell.titleLabel, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)

        //image view
        var c8 = NSLayoutConstraint(item: cell.imageView!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: 6)
        var c9 = NSLayoutConstraint(item: cell.imageView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 7)
        var c10 = NSLayoutConstraint(item: cell.imageView!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 50)
        var c11 = NSLayoutConstraint(item: cell.imageView!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 50)
        cell.addConstraints([c1,c2,c3,c4,c5,c6,c8,c9,c10,c11])
        
    }

}
