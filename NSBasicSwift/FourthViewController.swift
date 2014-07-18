//
//  FourthViewController.swift
//  NSBasicSwift
//
//  Created by Nithin Sathyan on 7/17/14.
//  Copyright (c) 2014 Nithin Sathyan. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation


class FourthViewController: UIViewController  {
    
    @IBOutlet var airplayButton: UIButton
    
    var playerItem:AVPlayerItem = AVPlayerItem()
    var playerView:UIView  = UIView()
    var videoPlayer :AVPlayer = AVPlayer()
    var playerLayer :AVPlayerLayer = AVPlayerLayer()
    
    var videoURL : NSURL = NSURL .URLWithString("http://content.uplynk.com/209da4fef4b442f6b8a100d71a9f6a9a.m3u8")
    var nsPlayer: MPMoviePlayerController = MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // playing with MPMoviePlayerController
        nsPlayer = MPMoviePlayerController(contentURL: videoURL)
        nsPlayer.movieSourceType = MPMovieSourceType.Streaming
        nsPlayer.fullscreen = true
        nsPlayer.allowsAirPlay = true
        nsPlayer.prepareToPlay()
        nsPlayer.view.frame = CGRectMake(10, 70, 300, 170)
        self.view.addSubview(nsPlayer.view)
        nsPlayer.play()
       
     }
   
    // playing with AVPlayer
    func createPlayer (){
        playerView   = UIView(frame: CGRectMake(10, 250, 300, 170))
        playerItem      = AVPlayerItem(URL:videoURL)
        videoPlayer     = AVPlayer(playerItem: self.playerItem)
        playerLayer     = AVPlayerLayer (player: self.videoPlayer)
        playerLayer.backgroundColor = UIColor.blackColor().CGColor
        playerLayer.frame = playerView.bounds
        videoPlayer.allowsExternalPlayback = true
        playerView.backgroundColor = UIColor.lightGrayColor()
        playerView.layer.addSublayer(self.playerLayer)
        self.view .addSubview(self.playerView);
        videoPlayer.play();
        
//        var mpv : MPVolumeView = MPVolumeView()
//        mpv.volumeSliderRectForBounds(CGRectMake(0, 0, 280, 30))
//        mpv.layer.cornerRadius = 15
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func airplayButtonAction(sender: AnyObject) {
         createPlayer()
    }
}
