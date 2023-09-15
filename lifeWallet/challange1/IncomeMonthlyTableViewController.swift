//
//  IncomeMonthlyTableViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 11.09.2023.
//

import UIKit

final class IncomeMonthlyTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var listIncome = [Income]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let today = Date() // Şu anki tarihi al
        let calendar = Calendar.current // Geçerli takvimi al

        let currentMonth = calendar.component(.month, from: today) // Ayı elde et
        let currentYear = calendar.component(.year, from: today)

        listIncome = Incomedao().readIncomesInLastMonth(team_id: UserDefaults.standard.integer(forKey: "team_id"), month: currentMonth, year: currentYear)
        tableView.reloadData()
    }
    
}

extension IncomeMonthlyTableViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listIncome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "individualTeamToIncomes", for: indexPath) as! IncomeTableViewCell
        
        cell.dateLabel.text = listIncome[indexPath.row].date
        cell.nameOfIncome.text = listIncome[indexPath.row].income_description
        cell.priceOfIncome.text = String(listIncome[indexPath.row].income!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil", handler: {
            (contextualAction, view, boolValue) in
            
            
            Incomedao().removeAnIncome(id: self.listIncome[indexPath.row].income_id!)
            self.listIncome = Incomedao().readIncomes(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"))
            tableView.reloadData()
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
