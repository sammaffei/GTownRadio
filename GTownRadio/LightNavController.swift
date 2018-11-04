//
//  LightNavController.swift
//  gtownradio
//
//  Created by Samuel Maffei on 10/28/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//
//  Nav override to light status bar
//

import UIKit

class LightNavController : UINavigationController
    {
    override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return .lightContent
        }
    }
