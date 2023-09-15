//
//  IncomesViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 9.09.2023.
//

import UIKit

final class IncomesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var myIncomesArray = [Income]()
    
    private var searchedWord = ""
    private var isSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myIncomesArray = Incomedao().readIncomes(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"))
        tableView.reloadData()
    }
}


extension IncomesViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myIncomesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "individualTeamToIncomes", for: indexPath) as! IncomeTableViewCell
        
        cell.dateLabel.text = myIncomesArray[indexPath.row].date
        cell.nameOfIncome.text = myIncomesArray[indexPath.row].income_description
        cell.priceOfIncome.text = String(myIncomesArray[indexPath.row].income!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil", handler: {
            (contextualAction, view, boolValue) in
            
            
            Incomedao().removeAnIncome(id: self.myIncomesArray[indexPath.row].income_id!)
            self.myIncomesArray = Incomedao().readIncomes(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"))
            tableView.reloadData()
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension IncomesViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedWord = searchText
        if (searchedWord != ""){
            isSearched = true
            myIncomesArray = Incomedao().searchTheWordInDescription(text: searchText, team_id: UserDefaults.standard.integer(forKey: "team_id"))
        }else{
            isSearched = false
            myIncomesArray = Incomedao().readIncomes(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"))
        }
        tableView.reloadData()
    }
}
