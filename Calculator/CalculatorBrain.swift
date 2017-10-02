//
//  CalculatorBrain.swift
//  Caluclator
//
//  Created by Donelys Familia on 9/6/17.
//  Copyright © 2017 Donelys Familia. All rights reserved.
//

import Foundation

// var  resultIsPending = false

class CalculatorBrain{
    
    private var trackingOperation : [String] = []
    
    private var trackingString = ""
    
    private var accumulator = 0.0
    
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case clear
        case Equals
        
        
        
    }
    
    var description : String{
        get{
            return trackingString
        }
    }
    
    
    private func clear(){
        accumulator = 0
        pbo = nil
        trackingString = ""
        
    }
    
    
    
    private var operations: Dictionary<String, Operation> =
        [
            
            "π" : Operation.Constant(Double.pi), // Double.pi,
            "e" : Operation.Constant(M_E), //M_E
            "±" : Operation.UnaryOperation({-$0 }),
            "√" : Operation.UnaryOperation(sqrt), //sqrt
            "cos" : Operation.UnaryOperation(cos),  // cos
            "sin" : Operation.UnaryOperation(sin),  // cos
            "tan" : Operation.UnaryOperation(tan),  // cos
            "+" : Operation.BinaryOperation({ $0 + $1}),
            "−" : Operation.BinaryOperation({ $0 - $1}),
            "÷" : Operation.BinaryOperation({ $0 / $1}),
            "x" : Operation.BinaryOperation({ $0 * $1}),
            "xʸ": Operation.BinaryOperation({ pow($0, $1)}),
            "C" : Operation.clear,
            "=" : Operation.Equals,
            
            
            
            ]
    
    
    private struct PendingBinaryOperation{
        let function : (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double{
            return function(firstOperand,secondOperand)
        }
    }
    private var pbo: PendingBinaryOperation?
    public func performOperaton(_ symbol: String) {
        
        if let operation = operations[symbol]{
            switch operation{
            case .Constant(let value):
                trackingOperation.append(symbol)
                accumulator = value
                trackingString += symbol
                
            case .UnaryOperation(let function):
                if accumulator != 0{
                    accumulator = function(accumulator)
                }
                trackingString += symbol
            case .BinaryOperation(let function):
                if(accumulator != 0){
                    pbo = PendingBinaryOperation(function: function,firstOperand: accumulator)
                    trackingString += symbol
                }
                
                
            case .Equals:
                if(pbo != nil && accumulator != 0){
                    accumulator = pbo!.perform(with: accumulator)
                    pbo = nil
                    
                    trackingString += symbol
                    
                    
                }
            case .clear:
                clear()
                
            }
            
        }
        
        
        
        
        
    }
    
    
    public func setOperant(_ operand: Double){
        accumulator = operand
        trackingString += String(format:"%2g",operand)
        
    }
    
    var result: Double! {
        get {
            return accumulator
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
