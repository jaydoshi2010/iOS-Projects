//
//  TicketModel.swift
//  Toronto Raptors
//
//  Created by Jay Doshi on 2023-10-24.
//

import Foundation

class TicketModel {
    var ticketTypes: [[String: Any]]

    // I used concept array of dictionaries
    init() {
        ticketTypes = [
            ["description": "Balcony Level Tickets", "pricePerTicket": 100, "quantity": 0],
            ["description": "Lower Level Tickets", "pricePerTicket": 500, "quantity": 0],
            ["description": "Courtside Tickets", "pricePerTicket": 1000, "quantity": 0]
        ]
    }
}




