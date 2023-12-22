//
//  HistoryViewController.swift
//  Toronto Raptors
//
//  Created by Jay Doshi on 2023-10-26.
//

import UIKit


class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TicketManager.purchasedTickets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let ticket = TicketManager.purchasedTickets[indexPath.row]

        // Configure the cell with the purchased ticket information
        cell.textLabel?.text = ticket["description"] as? String
        cell.detailTextLabel?.text = "\(ticket["quantity"] ?? 0)"

        return cell
    }

    
    // transfering data from this controller to DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
               let detailVC = segue.destination as? DetailViewController {
                let selectedTicket = TicketManager.purchasedTickets[indexPath.row]
                detailVC.ticket = selectedTicket
            }
        }
    }

    
   
    


}
