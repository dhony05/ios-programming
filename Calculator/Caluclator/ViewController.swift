//
//  ViewController.swift
//  Caluclator
//
//  Created by Donelys Familia on 9/1/17.
//  Copyright © 2017 Donelys Familia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsInTheMiddleOfTyping = false
    
     var variableM = [String: Double]()
    private var brain = CalculatorBrain()
    @IBOutlet weak var displayOperation: UILabel!
    
    @IBOutlet weak var mlabel: UILabel!
    var eme : String {
        get {
            return mlabel.text!
        }
        set {
            mlabel.text! = "M:" + String(newValue)
        }
    }
    @IBOutlet weak var display: UILabel! // will unwrap every display
    
    
    @IBAction func und0(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping,var inText = display.text{
            inText .remove(at: inText.index(before: inText.endIndex))
            if inText.isEmpty{
              inText = "0"
              userIsInTheMiddleOfTyping = false
            }
            display.text = inText
    }
    
    }
  
    @IBAction func m_setvariables(_ sender: UIButton) {
        variableM["M"] = displayValue
        eme = String(variableM["M"]!)
        displayValue = 0.0
        userIsInTheMiddleOfTyping = false
    }
    
    @IBAction func m_value(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        brain.setOperand(variable: "M")
        brain.setAccumulator(variableM["M"]!)
        displayOperation.text = brain.description
        
    }
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        //userIsInTheMiddleOfTyping = true
        
        
        let digit = sender.currentTitle!
        
        //  print("\(digit) was touched")
        if userIsInTheMiddleOfTyping{
            //let to create a local variable
            let texCurrentlyInDisplay = display.text!
            
            if digit != "." || display.text!.range(of: ".") == nil {
                // displayOperation.text = texCurrentlyInDisplay + digit
                display.text = texCurrentlyInDisplay + digit
            }
        } else {
            if digit == "."{
                display.text = "0\(digit)"
                
            }else {
                display.text = digit
            }
        }
        
        userIsInTheMiddleOfTyping = true
        
    }
    private var formatter: NumberFormatter { //  Extra Credit : formatter
        get {
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 6
            return formatter
        }
    }
    var displayValue: Double{
        
        get{
            
            return Double(display.text!)!
            
            
        }
        set {
            
            display.text = formatter.string(from: NSNumber(value: newValue))!
            userIsInTheMiddleOfTyping = false
        }
    }
    
    
   
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        if(userIsInTheMiddleOfTyping) {
            brain.setOperant(displayValue) //whatever is on display
            userIsInTheMiddleOfTyping = false
            
        }
         if let mathematicalSymbol = sender.currentTitle{
            brain.performOperaton(mathematicalSymbol)
            userIsInTheMiddleOfTyping = false
            
            
        }
         if sender.currentTitle! == "C" {
            displayOperation.text = "0"
            displayValue = 0
            mlabel.text = "0"
        }
            
        
        else  {
            
            displayOperation.text = brain.description
            displayValue = brain.result
            
        }
        
    }
}
