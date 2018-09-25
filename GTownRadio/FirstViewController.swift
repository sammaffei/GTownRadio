//
//  FirstViewController.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/7/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import UIKit
import Alamofire
import AlamoFuzi
import FRadioPlayer

class FirstViewController: UIViewController, FRadioPlayerDelegate {
    
    var nowPlayingVC : NowPlayingViewController?
    
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }

    
    @IBAction func togglePlaying(sender: UIButton)
        {
        if FRadioPlayer.shared.isPlaying
            {
            FRadioPlayer.shared.pause()
            sender.setTitle("Play".localized(), for: .normal)
            }
        else
            {
            FRadioPlayer.shared.play()
            sender.setTitle("Stop".localized(), for: .normal)
            }
            
        nowPlayingVC?.isPlaying = FRadioPlayer.shared.isPlaying
            
        }
                
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let _ = NowPlayingTask.shared
        
        FRadioPlayer.shared.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier
            {
            case "NowPlayingEmbedID":
                if let nPVC = segue.destination as? NowPlayingViewController
                    {
                    nowPlayingVC =  nPVC
                    }
            
            
            default:
                break
            }
    }


}

