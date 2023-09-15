//
//  FridayViewController.swift
//  LessonProgram
//
//  Created by Furkan Ekinci on 13.09.2023.
//

import UIKit
import CoreData

final class FridayViewController: UIViewController {
    
    private let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var tableView: UITableView!
    
    private var lessons = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lessons = [String]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Lessons")
        fetchRequest.predicate = NSPredicate(format: "lesson_day == %@", "cuma")
        
        do{
            let ls = try context.fetch(fetchRequest)
            for l in ls {
                if let name = l.value(forKey: "lesson_name") as? String{
                    lessons.append(name)
                }
            }
        }catch{
            print("Hata: Veri çekilemedi.")
        }
        tableView.reloadData()
        dump(lessons)
    }
    
    func findRightLessonForTheRow(time:Int, day:String)->String{
        
        var returnString = String()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Lessons")
        fetchRequest.predicate = NSPredicate(format: "lesson_day == %@ AND lesson_time == %d",day,time)
        
        do{
            let ls = try context.fetch(fetchRequest)
            for l in ls{
                returnString = l.value(forKey: "lesson_name") as! String
            }
            //returnString = ls[0].value(forKey: "lesson_name") as! String

        }catch{
            print("Hata: Veri çekilemedi.")
        }
        
        return returnString
    }
}

extension FridayViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
        //return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fridayCell", for: indexPath) as! FridayTableViewCell
        
        cell.fridayLabel.text = self.findRightLessonForTheRow(time: (indexPath.row + 1), day: "cuma")
        
        return cell
    }
}
