//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//c

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts: [NSDictionary] =  [NSDictionary]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        
        tableView.delegate = self
        tableView.dataSource = self

        reload()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        FBRequestConnection.startWithGraphPath("/me/home", parameters: nil, HTTPMethod: "GET") { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            
            
            var response = result as FBGraphObject
            var allPosts = response["data"] as [NSDictionary]
            
            self.posts = allPosts.filter {
                (var post: NSDictionary) -> Bool in
                
                if let _ = post["message"] { // underscore b/c we don't use the variable anyway
                    return true
                }
                return false
            }
            
            self.tableView.reloadData()
            
            println("\(result)")
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var post = self.posts[indexPath.row] as FBGraphObject
        let message = post["message"] as? NSString
        if let photo = post["picture"] as? NSString {
            var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoCell
            cell.photoView.setImageWithURL(NSURL(string: photo))
            cell.messageLabel.text = message
            return cell
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("StatusCell", forIndexPath: indexPath) as StatusCell
            cell.messageLabel.text = message
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
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
