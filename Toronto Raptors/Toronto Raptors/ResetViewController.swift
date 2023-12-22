//
//  ResetViewController.swift
//  Toronto Raptors
//
//  Created by Jay Doshi on 2023-10-14.
//

import UIKit


// Declare a reference to the AppDelegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ResetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var resetTextField: UITextField!
    @IBOutlet weak var resetPickerView: UIPickerView!
    
   // var ticketModel = TicketModel() // TicketModel class
    var selectedTicketIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetPickerView.delegate = self
        resetPickerView.dataSource = self
        resetTextField.delegate = self
        
        // Initialize the pickerView with the default value.
        resetPickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
    // UIPickerViewDataSource methods:
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appDelegate.globalTicketModel.ticketTypes.count
    }
    
    // UIPickerViewDelegate methods:
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ticketType = appDelegate.globalTicketModel.ticketTypes[row]
        if let description = ticketType["description"] as? String,
           let pricePerTicket = ticketType["pricePerTicket"] as? Int,
           let quantity = ticketType["quantity"] as? Int {
                let totalPrice = pricePerTicket * quantity
                return "\(description) \(quantity) : $\(totalPrice)"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTicketIndex = row
    }
    

    // ok btn pressed
    @IBAction func okButtonTapped(_ sender: Any) {
        if let quantity = Int((resetTextField.text)!){
            appDelegate.globalTicketModel.ticketTypes[selectedTicketIndex]["quantity"] = quantity
            resetPickerView.reloadComponent(0)
            resetTextField.text = ""
        }
        
    }
    
    // cancel btn pressed
    @IBAction func cancelButtonTapped(_ sender: Any) {
        resetTextField.text = ""
    }
    
}
