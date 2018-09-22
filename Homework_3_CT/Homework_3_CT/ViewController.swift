//
//  ViewController.swift
//  Homework_3_CT
//
//  Created by CIS Student on 9/22/18.
//  Copyright © 2018 CIS Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {

    @IBOutlet weak var mode_Button: UIButton!
    @IBOutlet weak var clear_Button: UIButton!
    @IBOutlet weak var calc_Button: UIButton!
    @IBOutlet weak var fromInput: UITextField!
    
    @IBOutlet weak var toInput: UITextField!
    
    @IBOutlet weak var from_Label: UILabel!
    
    @IBOutlet weak var to_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit) {
        //add code for picker selection
        
        from_Label.text = fromUnits.rawValue
        to_Label.text = toUnits.rawValue
        
    }
    
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit) {
        //add code for picker selection
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? Mode_Select_ViewController{
            dest.delegate = self
        }
    }
    
}

