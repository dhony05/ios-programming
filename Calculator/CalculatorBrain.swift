//
//  CalculatorBrain.swift
//  Caluclator
//
//  Created by Donelys Familia on 9/6/17.
//  Copyright © 2017 Donelys Familia. All rights reserved.
//

import Foundation


private var  resultIsPending: Bool = false

class CalculatorBrain{
    private var isOperation:Bool = false
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
            if resultIsPending{
                return trackingString + "..."
            }else if(isOperation){
                return trackingString + "="
            }else{
                return trackingString
            }
            
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
                    accumulator =  function(accumulator)
                    if !trackingString.isEmpty{
                        trackingString = symbol + "(" + trackingString + ")"
                    }

                }
            case .BinaryOperation(let function):
                if(accumulator != 0){
                    pbo = PendingBinaryOperation(function: function,firstOperand: accumulator)
                    resultIsPending = true
                    trackingString += symbol
                    
                }
                
                
            case .Equals:
                if(pbo != nil && accumulator != 0){
                    accumulator = pbo!.perform(with: accumulator)
                    pbo = nil
                    resultIsPending = false
                    isOperation = true
                    
                    
                    
                }
            case .clear:
                resultIsPending = false
                isOperation = false
                clear()
                
            }
            
        }
        
        
        
        
        
    }
    
    
    public func setOperant(_ operand: Double){
        
        accumulator = operand
        trackingString += String(format:"%2g",operand)
        
        
    }
    
    func setAccumulator(_ operand: Double) {
        accumulator = operand
    }
    func setOperand(variable name: String){
        trackingString += name
        
    }
    
    var result: Double! {
        get {
            return accumulator
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
