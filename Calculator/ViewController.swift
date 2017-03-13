//
//  ViewController.swift
//  Calculator
//
//  Created by Yeleswarapu, Chakravarthy on 3/4/17.
//  Copyright © 2017 Yeleswarapu, Chakravarthy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    var defaultCurrencySymbol: String = "$"
    var defaultSliderValue: Int = 10
    let tipPercentages = [0.10, 0.15, 0.20]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC: view did load")
        // Do any additional setup after loading the view, typically from a nib.
        launchedBeforeCheck()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calulateTip(_ sender: AnyObject) {
       
        let bill = Double(billField.text!) ?? 0

        let tipSegementSelectedString = tipSegment.titleForSegment(at: tipSegment.selectedSegmentIndex)!
        let tipPercentage = Double(tipSegementSelectedString.substring(to: tipSegementSelectedString.index(before: tipSegementSelectedString.endIndex)))?.divided(by: Double(100))
        let tip = bill * tipPercentage!
        let total = bill + tip
        tipLabel.text = defaultCurrencySymbol + String(format: "%.2f", tip)
        totalLabel.text = defaultCurrencySymbol + String(format: "%.2f",total)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC: view will appear")
        
        defaultCurrencySymbol = defaults.string(forKey: "currencySymbolSegment.value") ?? defaultCurrencySymbol
        defaultSliderValue = defaults.integer(forKey: "slider.value")
        
        print("currencySymbolSegment.value: \(defaults.string(forKey: "currencySymbolSegment.value"))")
        print("slider.value: \(defaults.double(forKey: "slider.value"))")
        
        tipSegment.setTitle(defaults.string(forKey: "tipSegment_0.value") ?? "10%", forSegmentAt: 0)
        tipSegment.setTitle(defaults.string(forKey: "tipSegment_1.value") ?? "15%", forSegmentAt: 1)
        tipSegment.setTitle(defaults.string(forKey: "tipSegment_2.value") ?? "20%", forSegmentAt: 2)
        tipSegment.selectedSegmentIndex = defaults.integer(forKey: "tipSegment.selected")
        
        calulateTip(animated as AnyObject)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC: view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC: view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("VC: view did disappear")
    }
    
    func launchedBeforeCheck() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        }
    }
}

