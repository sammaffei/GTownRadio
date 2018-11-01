//
//  GTownViewController.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/7/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import UIKit
import Alamofire
import AlamoFuzi
import FRadioPlayer

import MediaPlayer

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
            case Constants.AppSegues.NowPlayingEmbedID:
                if let nPVC = segue.destination as? NowPlayingViewController
                    {
                    nowPlayingVC =  nPVC
                    }
            
            case Constants.AppSegues.SettingsPopoverSegueID:
                
                guard let settingsVC = segue.destination as? UIViewController,
                    let popPresenter = settingsVC.popoverPresentationController
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
