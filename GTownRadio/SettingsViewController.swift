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
    @IBOutlet var infoTextView : UITextView!
    
    private func setVersionAppInfoLabel()
    {
        guard let infoText = infoTextView.text
            else {return}
        
        var replaceStr = "????"
        
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"),
            let buildNum = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
            {
            replaceStr = "\(version) (\(buildNum))"
            }
        
        infoTextView.text = (infoText as NSString).replacingOccurrences(of: "#vers#", with: replaceStr)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loFiOnCellSwitch.isOn = UserDefaults.standard.useLoFiOnCell()
        
        setVersionAppInfoLabel()
    }
    
    
    @IBAction func loFiCellSwitchChange(_ sender: UISwitch)
        {
        let lastRadioURL = FRadioPlayer.shared.radioURL
        let wasPlaying = FRadioPlayer.shared.isPlaying
            
        UserDefaults.standard.setUseLoFiOnCell(value: sender.isOn)
            { (useLoFi : Bool) in
                
            let prefURL = UserDefaults.standard.radioPlayerURL()
                
            FRadioPlayer.shared.radioURL = prefURL

            if wasPlaying && (prefURL != lastRadioURL)
                {
                // Need a delay for AV to reset before starting play again. If it doesn't work it's only
                // a minor fail becuase it only happens when fidelity changes while playing.
                    
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        FRadioPlayer.shared.play()
                    }
                }
            }
        }
}
