//
//  WatchingsViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 10.09.2023.
//

import UIKit

final class WatchingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var listOfWatchings = [Film]()
    
    private var searchedWord = ""
    private var isSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listOfWatchings = Filmdao().readFilms(user_id: UserDefaults.standard.integer(forKey: "user_id"))
        tableView.reloadData()
    }

}

extension WatchingsViewController:UITableViewDelegate, UITableViewDataSource{
    
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

extension WatchingsViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedWord = searchText
        if (searchedWord != ""){
            isSearched = true
            listOfWatchings = Filmdao().searchTheWordInName(text: searchText, user_id: UserDefaults.standard.integer(forKey: "user_id"))
        }else{
            isSearched = false
            listOfWatchings = Filmdao().readFilms(user_id: UserDefaults.standard.integer(forKey: "user_id"))
        }
        tableView.reloadData()
    }
}
