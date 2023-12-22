//
//  ViewController.swift
//  Calculator
//
//  Created by Jay Doshi on 2023-09-29.
//

import UIKit

class ViewController: UIViewController {

    let calculatorModel = CalculatorBrain()
    
    var userInput = [String]()
    var currentOperation: String? = nil
    
    
    @IBOutlet weak var dataField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // Numbers:
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            userInput.append(number)
            dataField.text = userInput.joined()
            
        }
    }
    
    // Arethmatic Operation:
    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        if let operation = sender.titleLabel?.text {
            currentOperation = operation
            userInput.append(currentOperation!)
            dataField.text = userInput.joined()
        }
    }
    
    // Calculate:
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        let result = calculatorModel.CalculatorBrain(getUserInput: userInput)
        userInput.removeAll()
        dataField.text=result.joined()
        
    }
    
    // clear:
    @IBAction func clearButton(_ sender: UIButton) {
        userInput.removeAll()
        currentOperation = nil
        dataField.text = "0"
    }
    
    

    

}

