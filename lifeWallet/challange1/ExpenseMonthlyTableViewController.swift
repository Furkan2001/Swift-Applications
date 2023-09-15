//
//  ExpenseMonthlyTableViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 11.09.2023.
//

import UIKit

final class ExpenseMonthlyTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var myExpensesArray = [Expense]()
    
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
        
        myExpensesArray = Expensedao().readExpensesInLastMonth(month: currentMonth, year: currentYear, team_id: UserDefaults.standard.integer(forKey: "team_id"))
        tableView.reloadData()
    }

}

extension ExpenseMonthlyTableViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myExpensesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "individualTeamToExpenses", for: indexPath) as! ExpenseTableViewCell
        
        cell.dateLabel.text = myExpensesArray[indexPath.row].date
        cell.nameOfExpense.text = myExpensesArray[indexPath.row].expense_description
        cell.priceOfExpense.text = String(myExpensesArray[indexPath.row].expense!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil", handler: {
            (contextualAction, view, boolValue) in
            
            
            Expensedao().removeAnExpense(id: self.myExpensesArray[indexPath.row].expense_id!)
            self.myExpensesArray = Expensedao().readExpenses(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"))
            tableView.reloadData()
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
