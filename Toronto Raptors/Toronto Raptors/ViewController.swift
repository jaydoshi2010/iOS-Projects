//
//  ViewController.swift
//  Toronto Raptors
//
//  Created by Jay Doshi on 2023-10-14.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectedOptionLabel: UILabel!
    @IBOutlet weak var TicketLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    
    var ticketPrice = 100
    
    // reference to the TicketModel
    var secondTicketModel: TicketModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set the secondPickerView's delegate and data source
        pickerView.delegate = self
        pickerView.dataSource = self

        // Initialize the secondPickerView with the globalTicketModel data
        secondTicketModel = appDelegate.globalTicketModel
    }
    
    // MARK: - UIPickerViewDataSource methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return secondTicketModel?.ticketTypes.count ?? 0
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let ticketModel = secondTicketModel, row < ticketModel.ticketTypes.count {
            let ticketType = ticketModel.ticketTypes[row]
            if let description = ticketType["description"] as? String,
               let pricePerTicket = ticketType["pricePerTicket"] as? Int,
               let quantity = ticketType["quantity"] as? Int {
                    let totalPrice = pricePerTicket * quantity
                    return "\(description) \(quantity) : $\(totalPrice)"
            }
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if let ticketModel = secondTicketModel, row < ticketModel.ticketTypes.count {
                let selectedTicket = ticketModel.ticketTypes[row]
                if let description = selectedTicket["description"] as? String {
                    switch row {
                                case 0:
                                    ticketPrice = 100
                                case 1:
                                    ticketPrice = 500
                                case 2:
                                    ticketPrice = 1000
                                default:
                                    ticketPrice = 100
                                }
                    selectedOptionLabel.text = "\(description)"
                }
            }
        }
    
    
    
    
    // this is for numer button and display into ticketlabel
    @IBAction func numberButtonPressed(_ sender: UIButton){
        
        if let number = sender.titleLabel?.text, let intValue = Int(number) {
            let calculationResult = intValue * ticketPrice
            TicketLabel.text = number
            displayLabel.text = "Total: \(calculationResult)"
        }
    }
    
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        
        // get the selectedRow from the pickerView
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        
        // Check if there are tickets available for this row
        if let ticketModel = secondTicketModel, selectedRow < ticketModel.ticketTypes.count {
            
            var selectedTicket = ticketModel.ticketTypes[selectedRow]
            
            // Decrement the quantity by 1 if it's greater than 0
            if selectedTicket["quantity"] is Int {
                selectedTicket["quantity"] = (selectedTicket["quantity"] as? Int ?? 0) - Int(TicketLabel.text ?? "0")!
                
                
                let description = selectedTicket["description"]
                let quantity = Int(TicketLabel.text!)
                let total = quantity! * ticketPrice
                
                
                let purchasedTicket: [String: Any] = [
                    "description": description!,
                    "quantity": quantity!,
                    "totalPrice": total
                ]
                TicketManager.purchasedTickets.append(purchasedTicket)
                
                
                print(TicketManager.purchasedTickets)
                
                // update the selectedTicket in the model
                ticketModel.ticketTypes[selectedRow] = selectedTicket
                
                // reload pickerView and labels
                pickerView.reloadComponent(0)
                TicketLabel.text = "Tickets"
                displayLabel.text = "Total: "
                
                
            }
            else{
                displayLabel.text = "Error!"
            }
        }
        else{
            displayLabel.text = "Error!"
        }
    }
    
}

