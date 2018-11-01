//
//  UserDefaults_GTownExtension.swift
//  gtownradio
//
//  Created by Samuel Maffei on 10/31/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import Foundation

typealias LoFiChangeCallback = (Bool) ->Void

extension UserDefaults
    {
    enum UserDefaultsKeys : String
        {
        case LoFiOnCell = "LoFiOnCell"
        }
    
    func setUseLoFiOnCell(value:Bool, changeCallback : LoFiChangeCallback?)
        {
        if (self.useLoFiOnCell() != value)
            {
            set(value, forKey: UserDefaultsKeys.LoFiOnCell.rawValue)
            changeCallback?(value)
            }
        }
    
    func useLoFiOnCell()->Bool
        {
        return bool(forKey: UserDefaultsKeys.LoFiOnCell.rawValue)
        }
    
    func radioPlayerURL()->URL
        {
        return self.useLoFiOnCell() ? Constants.RadioPlayerURLs.LoFi : Constants.RadioPlayerURLs.HiFi
        }
    }
