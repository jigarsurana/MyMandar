//
//  AddFeedViewController.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/14/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class AddFeedViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
