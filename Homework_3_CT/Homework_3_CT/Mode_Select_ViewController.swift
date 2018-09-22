//
//  Mode_Select_ViewController.swift
//  Homework_3_CT
//
//  Created by CIS Student on 9/22/18.
//  Copyright © 2018 CIS Student. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit)
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit)
}

class Mode_Select_ViewController: UIViewController {
    
    var fromPickerData: [String] = [String]()
    var selection : String = ""
    var delegate : SettingsViewControllerDelegate?

    @IBOutlet weak var From_Output: UILabel!
    @IBOutlet weak var from_Picker: UIPickerView!
    
    @IBOutlet var Screen: UIView!
    @IBOutlet weak var To_Output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        from_Picker.isHidden = true
        
        for item in LengthUnit.allCases {
            self.fromPickerData.append(item.rawValue)
        }
        
        self.from_Picker.delegate = self
        self.from_Picker.dataSource = self
        
        let fromtap = UITapGestureRecognizer(target: self, action: #selector(Mode_Select_ViewController.fromTap))
        From_Output.isUserInteractionEnabled = true
        From_Output.addGestureRecognizer(fromtap)
        let totap = UITapGestureRecognizer(target: self, action: #selector(Mode_Select_ViewController.toTap))
        To_Output.isUserInteractionEnabled = true
        To_Output.addGestureRecognizer(totap)
        
        let screentap = UITapGestureRecognizer(target: self, action: #selector(Mode_Select_ViewController.screenTap))
        Screen.addGestureRecognizer(screentap)
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let d = self.delegate {
            var from_val: LengthUnit
            var to_val: LengthUnit
            
            if(From_Output.text == "Miles"){
                from_val = LengthUnit.Miles
            }
            else if(From_Output.text == "Meters") {
                from_val = LengthUnit.Meters
            }
            else{
                from_val = LengthUnit.Yards
            }
            if(To_Output.text == "Miles"){
                to_val = LengthUnit.Miles
            }
            else if(To_Output.text == "Meters"){
                to_val = LengthUnit.Meters
            }
            else{
                to_val = LengthUnit.Yards
            }
            
            d.settingsChanged(fromUnits: from_val, toUnits: to_val)
        }
    }
    
    @objc
    func fromTap(sender:UITapGestureRecognizer){
        From_Output.text = ""
        from_Picker.isHidden = false
    }
    
    @objc
    func toTap(sender:UITapGestureRecognizer){
        To_Output.text = ""
        from_Picker.isHidden = false
    }
    
    @objc
    func screenTap(sender:UITapGestureRecognizer){
        if(From_Output.text == ""){
            From_Output.text = selection
        }
        else if(To_Output.text == ""){
            To_Output.text = selection
        }
        from_Picker.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Mode_Select_ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fromPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.fromPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selection = self.fromPickerData[row]
    }
}
