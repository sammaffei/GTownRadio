//
//  GTownTVViewController.swift
//  gtowntv
//
//  Created by Samuel Maffei on 11/21/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import UIKit

class GTownTVViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let _ = NowPlayingTask.shared
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

