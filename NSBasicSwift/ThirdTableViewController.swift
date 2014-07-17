//
//  ThirdTableViewController.swift
//  NSBasicSwift
//
//  Created by Nithin Sathyan on 7/14/14.
//  Copyright (c) 2014 Nithin Sathyan. All rights reserved.
//

import UIKit


class NSTableViewCell: UITableViewCell {
    
    @IBOutlet var myImageview: UIImageView
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var price: UILabel
    @IBOutlet var rating: UILabel
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        create()
    }
    
    func create(){
        myImageview.image = UIImage(named: "image")
        titleLabel.text = "empty"
        
        myImageview.layer.cornerRadius = 15
        myImageview.layer.borderWidth = 0.1
        myImageview.layer.masksToBounds = true;
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}



class ThirdTableViewController: UITableViewController {
    
    var webData: NSMutableData = NSMutableData()
    var listArray : NSMutableArray = []
    var imageCache = NSMutableDictionary()
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchItunesFor("run")
        loadingIndicator.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchItunesFor(searchTerm: String) {
        
        //Clean up the search terms by replacing spaces with +
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ",
            withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch,
            range: nil)
        
        var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
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
        self.webData = NSMutableData()
    }
    
    //Append incoming data
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.webData.appendData(data)
    }
    
    //NSURLConnection delegate function
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        //Finished receiving data and convert it to a JSON object
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(webData,
            options:NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        listArray = (jsonResult["results"] as NSMutableArray)
        
        self.tableView .reloadData()
        loadingIndicator.stopAnimating()
        
    }
    
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return listArray.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let cell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as NSTableViewCell
        
        // Configure the cell...
        let itemDictionary : NSDictionary = listArray[indexPath!.row] as  NSDictionary
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // Jump in to a background thread to get the image for this item
            
            // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
            var urlString: NSString = itemDictionary.valueForKey("artworkUrl60") as NSString
            
            // Check our image cache for the existing key. This is just a dictionary of UIImages
            var image: UIImage? = self.imageCache.valueForKey(urlString) as? UIImage
            
            if( !image? ) {
                // If the image does not exist, we need to download it
                var imgURL: NSURL = NSURL(string: urlString)
                
                // Download an NSData representation of the image at the URL
                var request: NSURLRequest = NSURLRequest(URL: imgURL)
                var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                    if !error? {
                        image = UIImage(data: data)
                        
                        // Store the image in to our cache
                        self.imageCache.setValue(image, forKey: urlString)
                        cell.myImageview.image = image
                    }
                    else {
                        println("Error: \(error.localizedDescription)")
                    }
                    })
            }
            else {
                cell.myImageview.image = image
            }
            })
        
        let rating : NSString = itemDictionary.valueForKey("trackContentRating") as NSString
        var attrs = [NSForegroundColorAttributeName: UIColor.blackColor()]
        
        var val : Int = rating.integerValue
        if val<5 { attrs = [NSForegroundColorAttributeName: UIColor.redColor()] }
        else { attrs = [NSForegroundColorAttributeName: UIColor.greenColor()] }
        
        var attributedString = NSMutableAttributedString(string: "Rating is ")
        var gString = NSMutableAttributedString(string:rating, attributes:attrs)
        attributedString.appendAttributedString(gString)
        
        cell.titleLabel.text = itemDictionary.valueForKey("trackCensoredName") as NSString
        cell.price.text = itemDictionary.valueForKey("formattedPrice") as NSString
        cell.rating.attributedText = attributedString
        
        return cell
    }
}
