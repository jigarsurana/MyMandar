//
//  EventsViewController.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/11/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!

    var textArray:[String] = ["hello","jinuuuu","mitishaaaa","aaaaasdadsa","aaasasd"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.textArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SmTestTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellE") as! SmTestTableViewCell
        cell.testTitleLabel.text = textArray[indexPath.row]
//        cell.uploadedByLabel.text = "- " + feed.uploaded_by
        setFeedCellConstraints(cell)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func setFeedCellConstraints(cell: SmTestTableViewCell) {
        //Title
//        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        cell.setTranslatesAutoresizingMaskIntoConstraints(false)
        var c1 = NSLayoutConstraint(item: cell.testTitleLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1, constant: 5)
        
//        var c2 = NSLayoutConstraint(item: cell.testTitleLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 5)
//        var c3 = NSLayoutConstraint(item: cell.testTitleLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 300)

        //        var c4 = NSLayoutConstraint(item: cell.titleLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: cell.uploadedByLabel, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        
//        //uploaded by
//        var c5 = NSLayoutConstraint(item: cell.uploadedByLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: cell, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1, constant: 5)
//        var c6 = NSLayoutConstraint(item: cell.uploadedByLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: cell, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 10)
//        //        var c7 = NSLayoutConstraint(item: cell.uploadedByLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: cell.titleLabel, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
//        
//        //image view
//        var c8 = NSLayoutConstraint(item: cell.imageView!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: 6)
//        var c9 = NSLayoutConstraint(item: cell.imageView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 7)
//        var c10 = NSLayoutConstraint(item: cell.imageView!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 50)
//        var c11 = NSLayoutConstraint(item: cell.imageView!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 50)
//        cell.addConstraints([c1,c2,c3,c4,c5,c6,c8,c9,c10,c11])
        cell.addConstraints([c1])
        

    }
}
