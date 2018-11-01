//
//  SettingsViewController.swift
//  gtownradio
//
//  Created by Samuel Maffei on 10/31/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import UIKit
import FRadioPlayer

class SettingsViewController : UITableViewController
    {
    @IBOutlet var loFiOnCellSwitch : UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loFiOnCellSwitch.isOn = UserDefaults.standard.useLoFiOnCell()
    }
    
    
    @IBAction func loFiCellSwitchChange(_ sender: UISwitch)
        {
        UserDefaults.standard.setUseLoFiOnCell(value: sender.isOn)
            { (useLoFi : Bool) in
            FRadioPlayer.shared.radioURL = UserDefaults.standard.radioPlayerURL()
            }
        }
}
