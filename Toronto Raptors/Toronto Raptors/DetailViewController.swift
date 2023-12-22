//
//  DetailViewController.swift
//  Toronto Raptors
//
//  Created by Jay Doshi on 2023-10-28.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var ticketName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var ticket: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let ticket = ticket {
            ticketName.text = ticket["description"] as? String
            quantity.text = "\(ticket["quantity"] ?? 0)"
            total.text = "\(ticket["totalPrice"] ?? 0)"
            
            let currentDate = Date() // Get the current date and time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy HH:mm a" // Customize date format as needed
            let formattedDate = dateFormatter.string(from: currentDate)

            date.text = "\(formattedDate)"
        }
        
    }
    
}
