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
    
    
    
    var to_Value: LengthUnit = LengthUnit.Yards
    var from_Value: LengthUnit = LengthUnit.Meters
    
    var to_Value_V: VolumeUnit = VolumeUnit.Gallons
    var from_Value_V: VolumeUnit = VolumeUnit.Liters
    
    var mode: CalculatorMode = CalculatorMode.Length
    
    struct ModeSelect {
        static var mode = "Length"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        let detectMetersBox = UITapGestureRecognizer(target: self, action: #selector(self.clearBoxMeters))
        let detectYardsBox = UITapGestureRecognizer(target: self, action: #selector(self.clearBoxYards))
        
        self.view.addGestureRecognizer(detectTouch)
        self.toInput.addGestureRecognizer(detectYardsBox)
        self.fromInput.addGestureRecognizer(detectMetersBox)
        
    }

    @objc func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func clearBoxMeters(){
        self.toInput.text = ""
    }
    @objc func clearBoxYards(){
        self.fromInput.text = ""
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit) {
        //add code for picker selection
        
        from_Label.text = fromUnits.rawValue
        to_Label.text = toUnits.rawValue
        
        to_Value = toUnits
        from_Value = fromUnits
        
    }
    
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit) {
        //add code for picker selection
        from_Label.text = fromUnits.rawValue
        to_Label.text = toUnits.rawValue
        
        to_Value_V = toUnits
        from_Value_V = fromUnits
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination.childViewControllers[0] as? Mode_Select_ViewController{
            dest.delegate = self
        }
    }
    
    @IBAction func calculateFunc(_ sender: UIButton) {
        var input: Double = 0.0
        
        if(fromInput.text == ""){
            input = Double(self.toInput.text!)!
        }else if(toInput.text == "") {
            input = Double(self.fromInput.text!)!
        }
        
        // let y = Double(self.yardsInput.text!)!
        //let x = Double(self.metersInput.text!)!
        var conv_num: Double = 0.0
        var solution: Double = 0.0
        
        if(ModeSelect.mode == "Length"){
        
        for value in lengthConversionTable {
            if value.key == LengthConversionKey(toUnits: to_Value, fromUnits: from_Value) {
                conv_num = value.value
            }
        }
        }
        else{
            for value in volumeConversionTable {
                if value.key == VolumeConversionKey(toUnits: to_Value_V, fromUnits: from_Value_V) {
                    conv_num = value.value
                }
            }
            
        }
        
        solution = input * conv_num
        if(toInput.text == ""){
            toInput.text = String(solution)
        }else if(fromInput.text == ""){
            fromInput.text = String(solution)
        }
        
        /*if self.yardsInput.text != "" || self.metersInput.text != ""{
         if self.yardsInput.text != ""{
         self.metersInput.text = String(y / 1.0936)}
         else {
         self.yardsInput.text = String(x * 1.0936)}
         }*/
        
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        self.fromInput.text = ""
        self.toInput.text = ""
        
        
    }
    
    @IBAction func modePressed(_ sender: UIButton) {
        if(ModeSelect.mode == "Length"){
            ModeSelect.mode = "Volume"
            from_Label.text = from_Value_V.rawValue
            to_Label.text = to_Value_V.rawValue
            toInput.placeholder = "Enter in Volume"
            fromInput.placeholder = "Enter in Volume"
        }
        else{
            ModeSelect.mode = "Length"
            from_Label.text = from_Value.rawValue
            to_Label.text = to_Value.rawValue
            toInput.placeholder = "Enter in Length"
            fromInput.placeholder = "Enter in Length"
        }
    }
    
    
}

