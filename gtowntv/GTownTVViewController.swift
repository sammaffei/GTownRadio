//
//  GTownTVViewController.swift
//  gtowntv
//
//  Created by Samuel Maffei on 11/21/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import UIKit

class GTownTVViewController: UIViewController, FRadioPlayerDelegate {
    
    @IBOutlet var playPauseButton : SVGPlayButton!

    var nowPlayingVC : NowPlayingViewController?
    
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }
    
    
    @IBAction func togglePlaying(sender: SVGPlayButton)
    {
        if FRadioPlayer.shared.isPlaying
        {
            FRadioPlayer.shared.pause()
            
            sender.playing = false
        }
        else
        {
            nowPlayingVC?.showLoadingUI()
            
            FRadioPlayer.shared.play()
            
            sender.playing = true
        }
        
        nowPlayingVC?.isPlaying = FRadioPlayer.shared.isPlaying
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let _ = NowPlayingTask.shared
        
        FRadioPlayer.shared.delegate = self
        
        playPauseButton.addTarget(self, action: #selector(togglePlaying(sender:)),
                                  for: UIControlEvents.primaryActionTriggered)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier
            {
            // Use embed to grab view controller
            
            case Constants.AppSegues.NowPlayingEmbedID:
                if let nPVC = segue.destination as? NowPlayingViewController
                {
                nowPlayingVC =  nPVC
                }
            
            default:
                break
        }
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        // Add support for play / pause button. People naturally want to hit the play
        // button and don't necessarily think of hitting the touch area.
        
        if let anyPress = presses.first, anyPress.type == .playPause
            {
            togglePlaying(sender: playPauseButton)
            }
        
        
    }
    
}

