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
//        self.tableView.rowHeight = 100;
    
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
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "feedDetailSegue" ) {
            let controller = segue.destinationViewController as! FeedDetailViewController
            
            if let feedIndex = tableView.indexPathForSelectedRow()?.row {
                controller.feedData = feeds[feedIndex]
            }
        }
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"FeedModel")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
//             print(results)
            
            
            for result in results {
                var title: String = result.valueForKey("title") as! String
                var desc: String = result.valueForKey("feed_description") as! String
                var uploader: String = result.valueForKey("uploader") as! String
                
                var feedd :Feed = Feed()
                feedd.uploaded_by = uploader
                feedd.feed_title = title
                feedd.feed_text = desc
                feedd.feed_image = "http://localhost:8000/static/media/feeds/levis-poster.jpg"
                
                feeds.append(feedd)
                self.tableView.reloadData()
//                    print(result.valueForKey("title"))
//                    print(result.valueForKey("feed_description"))
//                    print(result.valueForKey("uploader"))
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

}
