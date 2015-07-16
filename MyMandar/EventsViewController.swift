//
//  EventsViewController.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/11/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var srchBar: UISearchBar!
    var seActive :Bool! = false
    
    var textArray:[String] = ["hello","jinuuuu","mitishaaaa","aaaaasdadsa","aaasasd"]
        var textArray1 = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        srchBar.showsScopeBar = true
        srchBar.delegate = self
        srchBar.placeholder = "search"

        // Do any additional setup after loading the view.
//        self.tableView.estimatedRowHeight = 100;
        
//        self.tableView.estimatedRowHeight = 100;
//        self.tableView.rowHeight = UITableViewAutomaticDimension;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {
        self.seActive = true
        srchBar.showsCancelButton = true
        self.tableView.reloadData()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.seActive = false
        srchBar.resignFirstResponder()
        srchBar.showsCancelButton = false
        srchBar.text = ""
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.seActive = true
        srchBar.showsCancelButton = true
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.seActive = false;
        self.tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        textArray1 = textArray.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(textArray1.count == 0){
            seActive = true;
        } else {
            seActive = true;
        }
        self.tableView.reloadData()
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
        if(seActive == true) {
            return self.textArray1.count
        }else {
            return self.textArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SmTestTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellE") as! SmTestTableViewCell
        
        if(self.seActive == true) {
          cell.testTitleLabel.text = textArray1[indexPath.row]
        } else {
         cell.testTitleLabel.text = textArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
