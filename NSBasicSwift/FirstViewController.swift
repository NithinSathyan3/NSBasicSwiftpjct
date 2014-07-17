//
//  FirstViewController.swift
//  NSBasicSwift
//
//  Created by Nithin Sathyan on 7/8/14.
//  Copyright (c) 2014 Nithin Sathyan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet var contentTextView : UITextView
    
    @IBOutlet var saveButton: UIButton
    
    let fileManager = (NSFileManager .defaultManager())
    let directorys : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
    let textfile = "myText.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.layer.cornerRadius = 8
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "keyboardhide")
        self.navigationItem.rightBarButtonItem = addButton
        
        // TapGestureRecognizer for hide keyboard.
        var tapGesture = UITapGestureRecognizer(target: self, action: "keyboardhide")
        self.view .addGestureRecognizer(tapGesture)
        
        let directories:[String] = directorys!;
        let dictionary = directories[0]; //documents directory
        
        let textpath = dictionary.stringByAppendingPathComponent(textfile); // File path.
        
        if fileManager .fileExistsAtPath(textpath){//    Reading file content.
            let reulttext  = String.stringWithContentsOfFile(textpath, encoding: NSUTF8StringEncoding, error: nil)
            contentTextView.text = reulttext
        }
        //UIButton Shape.
        saveButton.layer.cornerRadius    = 15

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide Keyboard.
    func keyboardhide() {
        contentTextView.resignFirstResponder()
    }
    
    @IBAction func doneBtnAction(sender : AnyObject) {
        println("done btn pressed")
        contentTextView.resignFirstResponder()
        
        let directories:[String] = directorys!;
        let dictionary = directories[0]; //documents directory
        let textpath = dictionary.stringByAppendingPathComponent(textfile);
        
        // Re-writing content
        var success : Bool = contentTextView.text.writeToFile(textpath, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
        
        if success{
            // Updating contentent
            let reulttext  = String.stringWithContentsOfFile(textpath, encoding: NSUTF8StringEncoding, error: nil)
            contentTextView.text = reulttext
        }
        else{
            println("error .......")
        }
    }
    
}
