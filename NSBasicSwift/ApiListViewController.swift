//
//  ApiListViewController.swift
//  NSBasicSwift
//
//  Created by Nithin Sathyan on 7/8/14.
//  Copyright (c) 2014 Nithin Sathyan. All rights reserved.
//

import UIKit

class ApiListViewController: UITableViewController ,TableViewCellDelegate{
    
    var webdata: NSMutableData = NSMutableData()
    var listArray : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchItunesFor("Note Stream")
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
        return listArray.count
    }
    
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        
//        let cell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
//        
//        // Configure the cell...
//        cell.textLabel.text = "Test 123"
//        return cell
        
        var cell:TableViewCell = tableView!.dequeueReusableCellWithIdentifier("cell") as TableViewCell
        
        // this is how you extract values from a tuple
        cell.delegate = self
        cell.titleLabel.text = "test title 1"
        return cell
    }
    
    func buttonClicked(cell: TableViewCell) {
        println("test 123")
    }
    
    
    
    func searchItunesFor(searchTerm: String) {
        
        //Clean up the search terms by replacing spaces with +
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ",
            withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch,
            range: nil)
        
        var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music"
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request,
            delegate: self,startImmediately: false)
        
        println("Search iTunes API at URL \(url)")
        
        connection.start()
    }
    
    //NSURLConnection Connection failed
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Failed with error:\(error.localizedDescription)")
    }
    
    //New request so we need to clear the data object
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response:NSURLResponse!) {
        self.webdata = NSMutableData()
    }
    
    //Append incoming data
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.webdata.appendData(data)
    }
    
    //NSURLConnection delegate function
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        //Finished receiving data and convert it to a JSON object
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(webdata,options:NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        listArray .addObjectsFromArray(jsonResult .valueForKey("results") as Array)
        println(listArray)
        self.tableView .reloadData()
    }
    
    
}
