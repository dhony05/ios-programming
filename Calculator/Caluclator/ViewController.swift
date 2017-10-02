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
    
    
    private var brain = CalculatorBrain()
    @IBOutlet weak var displayOperation: UILabel!
    
    @IBOutlet weak var display: UILabel! // will unwrap every display
    
    
    
    
    
    
    
    
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
        }
        else {
            displayOperation.text = brain.description
            displayValue = brain.result
        }
        
    }
}
