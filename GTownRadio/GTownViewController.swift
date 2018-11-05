//
//  GTownViewController.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/7/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import UIKit
import MediaPlayer
import StoreKit

import Alamofire
import AlamoFuzi
import FRadioPlayer

class GTownViewController: UIViewController, FRadioPlayerDelegate, UIPopoverPresentationControllerDelegate {
    
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
                
            if #available(iOS 10.3, *)
                {
                UserDefaults.standard.incrementPlayCount()
                }
            
            sender.playing = true
            }
            
        nowPlayingVC?.isPlaying = FRadioPlayer.shared.isPlaying
            
        }
                
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let _ = NowPlayingTask.shared
        
        FRadioPlayer.shared.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 10.3, *)
            {
            if UserDefaults.standard.reachedPlayCountRatingThreshold()
                {
                // Delay just a bit to not be jarring
                    
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
                    {
                    SKStoreReviewController.requestReview()
                    }

                // request review, then reset request for much longer period
                    
                UserDefaults.standard.pushBackPlayCount()
                }
            }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
            
            case Constants.AppSegues.SettingsPopoverSegueID:
                
                // Support popover for settings / about
                
                let settingsVC = segue.destination
                
                guard let popPresenter = settingsVC.popoverPresentationController
                    else { return }

                settingsVC.modalPresentationStyle = .popover

                popPresenter.backgroundColor = settingsVC.view.backgroundColor
                
                popPresenter.delegate = self                
                
                break
            
            
            default:
                break
            }
    }

}

