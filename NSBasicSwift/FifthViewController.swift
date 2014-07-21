//
//  FifthViewController.swift
//  NSBasicSwift
//
//  Created by Nithin Sathyan on 7/21/14.
//  Copyright (c) 2014 Nithin Sathyan. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {
    
    @IBOutlet var NSwebview: UIWebView
    
    @IBOutlet var NSsegmentcontrol: UISegmentedControl
    
    @IBOutlet var imageButton: UIButton
    @IBOutlet var pdfButton: UIButton
    @IBOutlet var textButton: UIButton
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageButton.layer.cornerRadius  =  imageButton.frame.size.width/2
        pdfButton.layer.cornerRadius    =  pdfButton.frame.size.width/2
        textButton.layer.cornerRadius   =  textButton.frame.size.width/2
        
        NSwebview .loadRequest(self .fileToURLRequest("sample.png"))
        imageButton.hidden  = false
        pdfButton.hidden    = true
        textButton.hidden   = true
        self.loadingIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentAction(sender: AnyObject) {
        
        switch self.NSsegmentcontrol.selectedSegmentIndex {
        case 0:
            NSwebview .loadRequest(self .fileToURLRequest("sample.png"))
            imageButton.hidden  = false
            pdfButton.hidden    = true
            textButton.hidden   = true
        case 1:
            NSwebview .loadRequest(self .fileToURLRequest(".pdf"))
            imageButton.hidden  = true
            pdfButton.hidden    = false
            textButton.hidden   = true
        case 2:
            NSwebview .loadRequest(self .fileToURLRequest(".txt"))
            imageButton.hidden  = true
            pdfButton.hidden    = true
            textButton.hidden   = false
        default:
            println("Nothing will happen")
        }
    }
    
    @IBAction func shareimgButtonAction(sender: AnyObject) {
        self.loadingIndicator.startAnimating()
        call_activityView([self .fileToURL("sample.png") as NSURL] as NSArray)
    }
    
    @IBAction func sharepdfButtonAction(sender: AnyObject) {
        self.loadingIndicator.startAnimating()
        call_activityView([self .fileToURL(".pdf") as NSURL] as NSArray)
    }
    
    @IBAction func sharetextButtonAction(sender: AnyObject) {
        self.loadingIndicator.startAnimating()
        call_activityView([self .fileToURL(".txt") as NSURL] as NSArray)
    }
    
    func fileToURLRequest(filename: String) -> NSURLRequest {
        let fileComponents: NSArray = filename .componentsSeparatedByString(".")
        let filePath : NSString     = NSBundle .mainBundle() .pathForResource(fileComponents.objectAtIndex(0) as String, ofType: fileComponents .objectAtIndex(1) as String)
        var url : NSURL = NSURL .fileURLWithPath(filePath)
        let urlRequest  = NSURLRequest(URL: url)
        return urlRequest
    }
    
    func fileToURL(filename: String) -> NSURL {
        let fileComponents: NSArray = filename .componentsSeparatedByString(".")
        let filePath : NSString     = NSBundle .mainBundle() .pathForResource(fileComponents.objectAtIndex(0) as String, ofType: fileComponents .objectAtIndex(1) as String)
        return NSURL.fileURLWithPath(filePath)
    }
    
    func call_activityView(objectsToShare: NSArray ){
        let activityViewController  = UIActivityViewController(activityItems:objectsToShare,applicationActivities: nil)
        self.navigationController.presentViewController(activityViewController,animated: true,completion: {
            self.loadingIndicator.stopAnimating()
            })
    }

}
