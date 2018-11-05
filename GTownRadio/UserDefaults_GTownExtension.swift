//
//  UserDefaults_GTownExtension.swift
//  gtownradio
//
//  Created by Samuel Maffei on 10/31/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//
//  Extension to support our app prefs
//

import Foundation
import Reachability

typealias LoFiChangeCallback = (Bool) ->Void

extension UserDefaults
    {
    enum UserDefaultsKeys : String
        {
        case LoFiOnCell = "LoFiOnCell"
        case PlayCountThreshold = "PlayCountThreshold"
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
    
    private func areOnCellular()->Bool
        {
        guard let curReach = Reachability()
            else {return false}
            
        return curReach.connection == .cellular
        }
    
    func radioPlayerURL()->URL
        {
        // use reachbility here to see if we are on cellular. If preference is set and on cell,
        // then return lo-fi url. Caller doesn't need to know the logic, just what URL was selected.
            
        return self.useLoFiOnCell() && areOnCellular() ? Constants.RadioPlayerURLs.LoFi :
                                                        Constants.RadioPlayerURLs.HiFi
        }
    
    func reachedPlayCountRatingThreshold()->Bool
        {
        return integer(forKey: UserDefaultsKeys.PlayCountThreshold.rawValue) > Constants.PlayCount.RatingThreshold
        }
    
    func pushBackPlayCount()
        // Kick back play count so as not to keep pestering user
        {
        set(-Constants.PlayCount.PushbackValue, forKey: UserDefaultsKeys.PlayCountThreshold.rawValue)
        }
    
    func incrementPlayCount()
        {
        set(integer(forKey: UserDefaultsKeys.PlayCountThreshold.rawValue) + 1,
                forKey: UserDefaultsKeys.PlayCountThreshold.rawValue)
        }
    }
