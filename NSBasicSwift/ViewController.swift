//
//  ViewController.swift
//  NSBasicSwift
//
//  Created by Nithin Sathyan on 7/8/14.
//  Copyright (c) 2014 Nithin Sathyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var apiButton: UIButton
    @IBOutlet var plistButton: UIButton
    @IBOutlet var textButton: UIButton
    @IBOutlet var videoPlayerButton: UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        apiButton.layer.cornerRadius    = 15
        plistButton.layer.cornerRadius  = 15
        textButton.layer.cornerRadius   = 15
        videoPlayerButton.layer.cornerRadius   = 15
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playButtonpress(sender: AnyObject) {
        
        println(" playButtonpress ")
        
      //  NSURL *movieURL = [NSURL URLWithString:@"http://example.com/somefile.mp4"];
       // movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
       // [self presentMoviePlayerViewControllerAnimated:movieController];
        //[movieController.moviePlayer play];
      
        
    }
    
}

