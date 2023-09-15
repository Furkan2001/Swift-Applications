//
//  BookMonthlyTableViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 11.09.2023.
//

import UIKit

final class BookMonthlyTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var listOfBooks = [Book]()
    
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
        
        listOfBooks = Bookdao().readBooksInLastMonth(user_id: UserDefaults.standard.integer(forKey: "user_id"), month: currentMonth, year:currentYear)
        tableView.reloadData()
    }

    
}

extension BookMonthlyTableViewController:UITableViewDelegate, UITableViewDataSource{
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
