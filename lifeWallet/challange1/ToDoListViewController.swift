//
//  ToDoListViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 5.09.2023.
//

import UIKit
import CoreData

final class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let context = appDelegate.persistentContainer.viewContext
    
    private var toDoList = [ToDoList]()
    
    private var searchedWord = ""
    private var isSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readFromDatabase()
        tableView.reloadData()
    }
    
    @IBAction func addNewItemToList(_ sender: Any) {
        let alertController = UIAlertController(title: "Yeni", message: "Yeni Görev Ekleyin", preferredStyle: .alert)
        
        alertController.addTextField{ textField in
            textField.placeholder = "Göreviniz"
        }
        
        let button = UIAlertAction(title: "Ekle", style: .destructive) { action in
            if let descriptionField = alertController.textFields?.first,
            let description = descriptionField.text {
                if description != "" {
                    let newRegistration = ToDoList(context:self.context)
                    newRegistration.description_list = description
                    newRegistration.done_list = false
                    appDelegate.saveContext()
                    self.viewWillAppear(false)
                    //self.readFromDatabase()
                    //self.tableView.reloadData()
                }
            }else {
                return
            }
        }
        alertController.addAction(button)
        self.present(alertController, animated: true)
    }
    
    func readFromDatabase(){
        do {
            toDoList = try context.fetch(ToDoList.fetchRequest())
        } catch {
            print("Hata: Veri çekilemedi.")
        }
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoList", for: indexPath) as! ToDoListTableViewCell
        
        var content = cell.defaultContentConfiguration()
        //cell.labelToDoList.text = "\(toDoList[indexPath.row].description_list ?? "")"
        content.text = "\(toDoList[indexPath.row].description_list ?? "")"
        cell.contentConfiguration = content
        
        if toDoList[indexPath.row].done_list == true{
           //cell.labelToDoList.textColor = UIColor.green
            cell.backgroundColor = UIColor.green
        }else{
            //cell.labelToDoList.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil", handler: {
            (contextualAction, view, boolValue) in
            
            self.context.delete(self.toDoList[indexPath.row])
            appDelegate.saveContext()
            
            self.viewWillAppear(false)
            //self.readFromDatabase()
            //self.tableView.reloadData()
        })
        
        let doneAction = UIContextualAction(style: .normal, title: "Tamamlandı", handler: {
            (contextualAction, view, boolValue) in
            if (self.toDoList[indexPath.row].done_list == false){
                do {
                    let dummyList = try self.context.fetch(ToDoList.fetchRequest())
                    let list = dummyList[indexPath.row]
                    list.done_list = true
                    appDelegate.saveContext()
                    self.viewWillAppear(false)
                    //self.readFromDatabase()
                    //self.tableView.reloadData()
                } catch {
                    print("güncelleme başarısız")
                }
            }
            })
            return UISwipeActionsConfiguration(actions: [deleteAction,doneAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (toDoList[indexPath.row].done_list == false){
            let alertController = UIAlertController(title: "Güncelle", message: "Görevi Güncelleyin", preferredStyle: .alert)
            
            alertController.addTextField{ textField in
                textField.text = self.toDoList[indexPath.row].description_list
            }
            
            let button = UIAlertAction(title: "Ekle", style: .destructive) { action in
                if let descriptionField = alertController.textFields?.first,
                   let description = descriptionField.text {
                    if description != "" {
                        do {
                            let dummy = try self.context.fetch(ToDoList.fetchRequest())
                            let tempToDo = dummy[indexPath.row]
                            tempToDo.description_list = description
                            appDelegate.saveContext()
                            print("update")
                            self.viewWillAppear(false)
                            //self.readFromDatabase()
                            //self.tableView.reloadData()
                        } catch {
                            print("güncelleme başarısız")
                        }
                    }
                }else {
                    return
                }
            }
            alertController.addAction(button)
            
            self.present(alertController, animated: true)
        }
    }
}

extension ToDoListViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let fetchRequest:NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "description_list CONTAINS[c] %@", searchText)
        searchedWord = searchText
        if (searchedWord != ""){
            isSearched = true
            do {
                toDoList = try context.fetch(fetchRequest)
            } catch {
                print("arama esnasında hata oluştu")
            }
        }else{
            isSearched = false
            readFromDatabase()
        }
        tableView.reloadData()
    }
}
