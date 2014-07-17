//
//  SecondTableViewController.swift
//  NSBasicSwift
//
//  Created by Nithin Sathyan on 7/8/14.
//  Copyright (c) 2014 Nithin Sathyan. All rights reserved.
//

import UIKit

class SecondTableViewController: UITableViewController {
    
    var arrayList : NSMutableArray = []
    var plistpath : NSString?
    
    let fileManager = (NSFileManager .defaultManager())
    let directorys : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject")
        self.navigationItem.rightBarButtonItem = addButton
        
        if (directorys! != nil){
            let directories:[String] = directorys!;
            let dictionary = directories[0]; //documents directory
            
            //  Create the Plist file  ....
            let plistfile = "myarrayPlist.plist"
            plistpath = dictionary.stringByAppendingPathComponent(plistfile);
            
            if  !fileManager .fileExistsAtPath(plistpath){
                //  Write array to plist
                var success : Bool = arrayList.writeToFile(plistpath, atomically: false)
                if success {
                    //  Fetching plist content into main Array..
                    arrayList.addObjectsFromArray(NSMutableArray .arrayWithContentsOfFile(plistpath))
                }
            }
            else{ //    Reading Plist file
                arrayList.addObjectsFromArray(NSMutableArray .arrayWithContentsOfFile(plistpath))
            }
        }
        else {
            println("Directory is empty")
        }
    }
    
    
    // Insert new object into plist and and reload UITableVIew.
    func insertNewObject() {
        arrayList.addObject("item \(arrayList.count + 1)")
        arrayList.writeToFile(plistpath, atomically: false)
        self.tableView .reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrayList.count
    }
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel.text = arrayList[indexPath!.row] as String
        return cell
    }
    
}
