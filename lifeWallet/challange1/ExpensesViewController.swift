//
//  ExpensesViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 10.09.2023.
//

import UIKit

final class ExpensesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var myExpensesArray = [Expense]()
    
    private var searchedWord = ""
    private var isSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myExpensesArray = Expensedao().readExpenses(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"))
        tableView.reloadData()
    }
}

extension ExpensesViewController:UITableViewDelegate, UITableViewDataSource{
    
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

extension ExpensesViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedWord = searchText
        if (searchedWord != ""){
            isSearched = true
            myExpensesArray = Expensedao().searchTheWordInDescription(text: searchText, team_id: UserDefaults.standard.integer(forKey: "team_id"))
        }else{
            isSearched = false
            myExpensesArray = Expensedao().readExpenses(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"))
        }
        tableView.reloadData()
    }
}
