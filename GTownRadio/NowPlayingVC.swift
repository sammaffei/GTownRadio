//
//  NowPlayingVC.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/23/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import UIKit

class NowPlayingVC : UIViewController
    {
    @IBOutlet fileprivate weak var albumArtImageView: UIImageView!
    
    @IBOutlet fileprivate weak var trackLabel: UILabel!
    
    @IBOutlet fileprivate weak var artistLabel: UILabel!
    
    var nowPlaying : NowPlayingInfo?
}
