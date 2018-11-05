//
//  Constants.swift
//  gtownradio
//
//  Created by Samuel Maffei on 10/31/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import Foundation

class Constants
    {
    struct AppSegues
        {
        static let NowPlayingEmbedID = "NowPlayingEmbedID"
        static let SettingsPopoverSegueID = "SettingsPopoverSegueID"
        }
    
    struct RadioPlayerURLs
        {
        static let HiFi = URL(string: "http://www.gtownradio.com/gtown_hi.m3u")!
        static let LoFi = URL(string: "http://www.gtownradio.com/gtown_lo.m3u")!
        }
    
    struct PlayCount
        {
        static let RatingThreshold : Int = 20
        static let PushbackValue : Int = 200
        }
    }
