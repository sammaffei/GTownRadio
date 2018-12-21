//
//  Globals.swift
//  gtownradio
//
//  Created by Samuel Maffei on 12/21/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//
//  Class for global, non-static data
//

import Foundation

class Globals
    {
    static let shared = Globals()
    
    var buildInfoStr: String
        {
        get
            {
            
            if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"),
                let buildNum = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
                {
                return "\(version) (\(buildNum))"
                }
            else
                {
                return "????"
                }

            }
        }
    }
