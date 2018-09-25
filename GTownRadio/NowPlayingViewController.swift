//
//  NowPlayingViewController.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/23/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import UIKit

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
    
    fileprivate func setNotPlayingInfoUI()
        {
        trackLabel.text = "Not Playing".localized()
        artistLabel.text = ""
        albumArtImageView.image = nil
        }
    
    fileprivate func setPlayingInfoUI()
        {
        guard let playInfo = NowPlayingTask.shared.curNowPlaying
            else {return}
            
    
        LastFM().loadAlbumArt(nowInfo: playInfo, loadCompl:
            { (fetchedImage : UIImage?) in
            self.albumArtImageView.image = fetchedImage
                
            self.trackLabel.text = playInfo.song             // Do this after image fetch so text doesn't change before image
            self.artistLabel.text = playInfo.artist
            })
    
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
    
    
    override func viewDidLoad() {
        NowPlayingTask.shared.addListener
            { (nowPlayInfo) in
            self.updateNowPlayingUI()
            }
    }

}
