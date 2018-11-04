//
//  StringExtension.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/23/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import Foundation

extension String {
    
    // very simple support for localized strings
    
    func localized(comment:String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
}
