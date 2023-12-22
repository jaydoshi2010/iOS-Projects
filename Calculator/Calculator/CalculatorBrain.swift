//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jay Doshi on 2023-10-05.
//

import Foundation
import UIKit

class CalculatorBrain{
    
    let validaationOperators: Set<String> = ["+", "-", "*", "/"]

    func multipleOperatorsCheck(_ getUserInput: [String]) -> Bool {
            var operatorCnt = 0
            for element in getUserInput {
                if validaationOperators.contains(element) {
                    operatorCnt += 1
                    if operatorCnt > 1 {
                        return true
                    }
                }
            }
            return false
        }
    
    func lastIndexValidation(_ getUserInput: [String]) -> Bool{
        
        if let lastElement = getUserInput.last {
            if(lastElement=="+" || lastElement=="-" || lastElement=="/" || lastElement=="*"){
                return true;
            }
        }
        return false;
    }
    
    func firstIndexValidation(_ getUserInput: [String]) -> Bool{
        
        if let firstElement = getUserInput.first {
            if(firstElement=="+" || firstElement=="-" || firstElement=="/" || firstElement=="*"){
                return true;
            }
        }
        return false;
    }
    
    func CalculatorBrain(getUserInput: [String]) -> Array<String> {
            
        if(multipleOperatorsCheck(getUserInput) && lastIndexValidation(getUserInput) && firstIndexValidation(getUserInput)){
            var newArray = getUserInput
            newArray.append("Error !")
            return newArray
        }
        else{

            if getUserInput.contains("+"){
                let indexOfplus = Int(getUserInput.firstIndex(of: "+") ?? 0)
                return opration(getUserInput:getUserInput, operators:"+", index: indexOfplus)
            }
            else if getUserInput.contains("-"){
                let indexOfminus = Int(getUserInput.firstIndex(of: "-") ?? 0)
                return opration(getUserInput:getUserInput, operators:"-", index: indexOfminus)
            }
            else if getUserInput.contains("/"){
                let indexOfdivide = Int(getUserInput.firstIndex(of: "/") ?? 0)
                return opration(getUserInput:getUserInput, operators:"/", index: indexOfdivide)
            }
            else if getUserInput.contains("*"){
                let indexOfmul = Int(getUserInput.firstIndex(of: "*") ?? 0)
                return opration(getUserInput:getUserInput, operators:"*", index: indexOfmul)
            }
        }
            return []
        
    }
    
    
    
    func opration(getUserInput: [String], operators: String, index: Int) -> Array<String>{

        if index >= 0 && index < getUserInput.count {
            // Create two new arrays by slicing the original array
            let firstPart = Array(getUserInput[0 ..< index]) // Elements before the splitIndex
            let secondPart = Array(getUserInput[index+1 ..< getUserInput.count]) // Elements from splitIndex to the end
            
            // Print the results for verify
            print("First Part:", firstPart)
            print("Second Part:", secondPart)
            
            let c = Int(firstPart.joined())
            let d = Int(secondPart.joined())
            
            var calc = 0;
            
            switch operators {
            case "+":
                calc = c! + d!
            case "-":
                calc = c! - d!
            case "/":
                calc = c! / d!
            case "*":
                calc = c! * d!
            default:
                break
            }

            var newArray = getUserInput
            
            newArray.append("=")
            newArray.append(String(calc))
            
            return newArray
            
        }
        return []
    }
    
}
