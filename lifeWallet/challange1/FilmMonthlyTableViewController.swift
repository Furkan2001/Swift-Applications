//
//  FilmMonthlyTableViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 11.09.2023.
//

import UIKit

final class FilmMonthlyTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var listOfWatchings = [Film]()
    
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
        
        listOfWatchings = Filmdao().readFilmInLastMonth(month: currentMonth, year: currentYear, user_id: UserDefaults.standard.integer(forKey: "user_id"))
        tableView.reloadData()
    }

}

extension FilmMonthlyTableViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWatchings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myWatchingCell", for: indexPath) as! MyWatchingsTableViewCell
        
        cell.dateLabel.text = listOfWatchings[indexPath.row].date
        cell.nameOfWatchingTextView.text = listOfWatchings[indexPath.row].film_name
        cell.typeOfWatchingLabel.text = FilmTypedao().findTheNameFromId(id: listOfWatchings[indexPath.row].film_type_id!)
        cell.timeOfWatchingLabel.text = String(listOfWatchings[indexPath.row].film_time!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil", handler: {
            (contextualAction, view, boolValue) in
            
            Filmdao().removeAFilm(id: self.listOfWatchings[indexPath.row].film_id!)
            self.listOfWatchings = Filmdao().readFilms(user_id: UserDefaults.standard.integer(forKey: "user_id"))
            tableView.reloadData()
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
