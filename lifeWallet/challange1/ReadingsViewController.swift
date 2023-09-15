//
//  ReadingsViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 10.09.2023.
//

import UIKit

final class ReadingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var listOfBooks = [Book]()
    
    private var searchedWord = ""
    private var isSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listOfBooks = Bookdao().readBooks(user_id: UserDefaults.standard.integer(forKey: "user_id"))
        tableView.reloadData()
    }

    

}

extension ReadingsViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myBookCell", for: indexPath) as! MyReadingsTableViewCell
        
        cell.dateLabel.text = listOfBooks[indexPath.row].date
        cell.nameOfBookTextVİew.text = listOfBooks[indexPath.row].book_name
        cell.numberOfBookPageLabel.text = String(listOfBooks[indexPath.row].book_page!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil", handler: {
            (contextualAction, view, boolValue) in
            
            Bookdao().removeABook(id: self.listOfBooks[indexPath.row].book_id!)
            self.listOfBooks = Bookdao().readBooks(user_id: UserDefaults.standard.integer(forKey: "user_id"))
            tableView.reloadData()
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ReadingsViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedWord = searchText
        if (searchedWord != ""){
            isSearched = true
            listOfBooks = Bookdao().searchTheWordInDescription(text: searchText, user_id: UserDefaults.standard.integer(forKey: "user_id"))
        }else{
            isSearched = false
            listOfBooks = Bookdao().readBooks(user_id: UserDefaults.standard.integer(forKey: "user_id"))
        }
        tableView.reloadData()
    }
}

