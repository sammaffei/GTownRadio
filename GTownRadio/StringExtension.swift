//
//  StringExtension.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/23/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import Foundation

extension String {
    
    func localized(comment:String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
}
