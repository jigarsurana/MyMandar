//
//  AddFeedViewController.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/14/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class AddFeedViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var uploaderLabel: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.delegate = self;
        self.uploaderLabel.delegate = self;
        
        textView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.clipsToBounds = true
//        [textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
//        [textView.layer setBorderWidth:2.0];
//        
//        //The rounded corner part, where you specify your view's corner radius:
//        textView.layer.cornerRadius = 5;
//        textView.clipsToBounds = YES;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAndUpload(sender: AnyObject) {
        self.saveWithTitle(self.titleLabel.text, uploader: self.uploaderLabel.text, desc: self.textView.text)
    }

    func saveWithTitle(title: String, uploader: String, desc: String) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("FeedModel",
            inManagedObjectContext:
            managedContext)
        
        let feed = FeedModel(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
    
        feed.uploader = uploader
        feed.title = title
        feed.feed_description = desc
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        } else {
            println("feed saved")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
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
