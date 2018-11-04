//
//  NowPlayingViewController.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/23/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//
//  Encapsulation of Now Plating display interface
//

import UIKit
import SwiftGifOrigin

class NowPlayingViewController : UIViewController
    {
    @IBOutlet fileprivate weak var albumArtImageView: UIImageView!
    
    @IBOutlet fileprivate weak var trackLabel: UILabel!
    
    @IBOutlet fileprivate weak var artistLabel: UILabel!
    
    var isPlaying : Bool = false
        {
        didSet
            {
            updateNowPlayingUI()
            }
        }
    
    // These images are small, so pre-load them
    
    fileprivate var missingArtworkImage : UIImage?
    fileprivate var loadingAnimatedImage : UIImage?
    fileprivate var defaultBackgroundImage : UIImage?
    fileprivate var showOtherContentImage : UIImage?


    
    fileprivate func setNotPlayingInfoUI()
        {
        artistLabel.text = "Press Play".localized()
        trackLabel.text = ""
        albumArtImageView.image = defaultBackgroundImage
        }
    
    fileprivate func setPlayingInfoUI()
        {
        guard let playInfo = NowPlayingTask.shared.curNowPlaying
            else {return}
            
        switch playInfo.contentType
            {
            case .promo:
                trackLabel.text = playInfo.song
                artistLabel.text = playInfo.artist
                albumArtImageView.image = showOtherContentImage
            case .show:
                trackLabel.text = playInfo.song
                artistLabel.text = playInfo.artist
                albumArtImageView.image = showOtherContentImage
            case .song:
                LastFM().loadAlbumArt(nowInfo: playInfo, loadCompl:
                    { (fetchedImage : UIImage?) in
                        
                        self.albumArtImageView.image = fetchedImage ?? self.missingArtworkImage
                        
                        self.trackLabel.text = playInfo.song             // Do this after image fetch so text doesn't change before image
                        self.artistLabel.text = playInfo.artist
                })

            }
        }
    
    func updateNowPlayingUI()
        {
        if self.isPlaying
            {
            setPlayingInfoUI()
            }
        else
            {
            setNotPlayingInfoUI()
            }

        }
    
    func showLoadingUI()
        {
        albumArtImageView.image = loadingAnimatedImage
        artistLabel.text = "Loading".localized()
        trackLabel.text = nil
        }
    
    override func viewDidLoad() {
        
        missingArtworkImage = UIImage(named: "MissingAlbumArtwork")   // Preload this and keep it around
        defaultBackgroundImage = UIImage(named: "GTOWN_Emblem")
        loadingAnimatedImage = UIImage.gif(name: "loading")
        showOtherContentImage = UIImage(named: "RadioTower")

        
        albumArtImageView.image = defaultBackgroundImage
        
        NowPlayingTask.shared.addListener
            { (nowPlayInfo) in
            self.updateNowPlayingUI()
            }
    }

}
