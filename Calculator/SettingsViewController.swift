//
//  SettingsViewController.swift
//  Calculator
//
//  Created by Yeleswarapu, Chakravarthy on 3/9/17.
//  Copyright © 2017 Yeleswarapu, Chakravarthy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {


    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currencySegement: UISegmentedControl!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        print("SVC: view did load")
        
        tipSegment.setTitle(defaults.string(forKey: "tipSegment_0.value") ?? "10%", forSegmentAt: 0)
        tipSegment.setTitle(defaults.string(forKey: "tipSegment_1.value") ?? "15%", forSegmentAt: 1)
        tipSegment.setTitle(defaults.string(forKey: "tipSegment_2.value") ?? "20%", forSegmentAt: 2)
        tipSegment.selectedSegmentIndex = defaults.integer(forKey: "tipSegment.selected")
        onTipSegmentSelected(true)
        
        if !(defaults.string(forKey: "currencySymbolSegment.value") ?? "").isEmpty {
            currencySegement.selectedSegmentIndex = defaults.integer(forKey: "currencySegment.selectedSegmentIndex")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
 
    
    @IBAction func onSliderChange(_ sender: AnyObject) {
        print("SVC: Slider editing ended")
        tipSegment.setTitle(String(format: "%.0f", slider.value).appending("%"), forSegmentAt: tipSegment.selectedSegmentIndex)

    }
    
    @IBAction func onTipSegmentSelected(_ sender: Any) {
        let tipSegementSelectedString = tipSegment.titleForSegment(at: tipSegment.selectedSegmentIndex)!
       // slider.value = Float(tipSegementSelectedString.substring(to: tipSegementSelectedString.endIndex))!
        print(tipSegementSelectedString.substring(to: tipSegementSelectedString.index(before: tipSegementSelectedString.endIndex)))
        slider.value = Float(tipSegementSelectedString.substring(to: tipSegementSelectedString.index(before: tipSegementSelectedString.endIndex)))!
    }
    
    @IBAction func onCurSymbolChange(_ sender: UISegmentedControl) {
        print("SVC: onCurSymbolChange")

        defaults.set(currencySegement.titleForSegment(at: currencySegement.selectedSegmentIndex)!, forKey: "currencySymbolSegment.value")
        defaults.set(currencySegement.selectedSegmentIndex, forKey: "currencySegment.selectedSegmentIndex")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SVC: view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SVC: view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SVC: view will disappear")
        
        defaults.set(tipSegment.titleForSegment(at: 0)!, forKey: "tipSegment_0.value")
        defaults.set(tipSegment.titleForSegment(at: 1)!, forKey: "tipSegment_1.value")
        defaults.set(tipSegment.titleForSegment(at: 2)!, forKey: "tipSegment_2.value")
        defaults.set(tipSegment.selectedSegmentIndex, forKey: "tipSegment.selected")
        defaults.synchronize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SVC: view did disappear")
        print("currencySymbolSegment.value: \(defaults.string(forKey: "currencySymbolSegment.value"))")
        print("slider.value: \(defaults.integer(forKey: "slider.value"))")
    }
}
