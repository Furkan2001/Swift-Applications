//
//  FridayForRegisterViewController.swift
//  LessonProgram
//
//  Created by Furkan Ekinci on 13.09.2023.
//

import UIKit
import CoreData

final class FridayForRegisterViewController: UIViewController {
    
    private let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var lesson1Text: UITextField!
    @IBOutlet weak var lesson2Text: UITextField!
    @IBOutlet weak var lesson3Text: UITextField!
    @IBOutlet weak var lesson4Text: UITextField!
    @IBOutlet weak var lesson5Text: UITextField!
    @IBOutlet weak var lesson6Text: UITextField!
    @IBOutlet weak var lesson7Text: UITextField!
    @IBOutlet weak var lesson8Text: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isThereAProgramForTheDay(day: "cuma") {
            buttonSave.setTitle("Güncelle", for: .normal)
            resultLabel.text = "Kaydedildi"
            resultLabel.backgroundColor = .green
        }else{
            resultLabel.backgroundColor = .gray
            resultLabel.text = "CUMA"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.readFromDatabaseForRows()
    }
    
    @IBAction func saveLessons(_ sender: Any) {
        
        if let lesson1 = lesson1Text, let lesson = lesson1.text, lesson != ""{
            
            self.createNewLesson(name: lesson, time: 1, day: "cuma")
            
        }else{
            if (isThisRowFull(time: 1, day: "cuma")){
                self.createNewLesson(name: "", time: 1, day: "cuma")
            }
        }
        if let lesson2 = lesson2Text, let lesson = lesson2.text, lesson != ""{
            
            self.createNewLesson(name: lesson, time: 2, day: "cuma")
            
        }else{
            if (isThisRowFull(time: 2, day: "cuma")){
                self.createNewLesson(name: "", time: 2, day: "cuma")
            }
        }
        if let lesson3 = lesson3Text, let lesson = lesson3.text, lesson != ""{
            
            self.createNewLesson(name: lesson, time: 3, day: "cuma")
            
        }else{
            if (isThisRowFull(time: 3, day: "cuma")){
                self.createNewLesson(name: "", time: 3, day: "cuma")
            }
        }
        if let lesson4 = lesson4Text, let lesson = lesson4.text, lesson != ""{
            
            self.createNewLesson(name: lesson, time: 4, day: "cuma")
            
        }else{
            if (isThisRowFull(time: 4, day: "cuma")){
                self.createNewLesson(name: "", time: 4, day: "cuma")
            }
        }
        if let lesson5 = lesson5Text, let lesson = lesson5.text, lesson != ""{
            
            self.createNewLesson(name: lesson, time: 5, day: "cuma")
            
        }else{
            if (isThisRowFull(time: 5, day: "cuma")){
                self.createNewLesson(name: "", time: 5, day: "cuma")
            }
        }
        if let lesson6 = lesson6Text, let lesson = lesson6.text, lesson != ""{
            
            self.createNewLesson(name: lesson, time: 6, day: "cuma")
            
        }else{
            if (isThisRowFull(time: 6, day: "cuma")){
                self.createNewLesson(name: "", time: 6, day: "cuma")
            }
        }
        if let lesson7 = lesson7Text, let lesson = lesson7.text, lesson != ""{
            
            self.createNewLesson(name: lesson, time: 7, day: "cuma")
            
        }else{
            if (isThisRowFull(time: 7, day: "cuma")){
                self.createNewLesson(name: "", time: 7, day: "cuma")
            }
        }
        if let lesson8 = lesson8Text, let lesson = lesson8.text, lesson != ""{
            
            self.createNewLesson(name: lesson, time: 8, day: "cuma")
            
        }else{
            if (isThisRowFull(time: 8, day: "cuma")){
                self.createNewLesson(name: "", time: 8, day: "cuma")
            }
        }
        resultLabel.text = "Kaydedildi"
        resultLabel.backgroundColor = .green
    
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "cuma")
        
        if (isThereAProgramForTheDay(day: "pazartesi") && isThereAProgramForTheDay(day: "salı") && isThereAProgramForTheDay(day: "çarşamba") && isThereAProgramForTheDay(day: "perşembe") && isThereAProgramForTheDay(day: "cuma")){
            performSegue(withIdentifier: "fridayToMonday", sender: nil)
        }
    }
    
    func isThereAProgramForTheDay(day:String)->Bool{
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Lessons")
        fetchRequest.predicate = NSPredicate(format: "lesson_day == %@", day)
        
        do{
            let ls = try context.fetch(fetchRequest)
            if (ls.count > 0){
                return true
            }
        }catch{
            print("Hata: Veri çekilemedi.")
        }
        return false
    }
    
    func deleteFromDatabase(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Lessons")
        
        do{
            let people = try context.fetch(fetchRequest)
            for person in people{
                self.context.delete(person)
            }
            appDelegate.saveContext()
        }catch{
            print("Hata: Veri silinemedi.")
        }
    }
    
    func readFromDatabaseForRows(){
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Lessons")
        fetchRequest.predicate = NSPredicate(format: "lesson_day == %@", "cuma")
        
        do{
            let ls = try context.fetch(fetchRequest)
            if (ls.count > 0){
                for l in ls {
                    if let name = l.value(forKey: "lesson_name") as? String{
                        if let time = l.value(forKey: "lesson_time") as? Int{
                            if (time == 1){
                                lesson1Text.text = name
                            }else if (time == 2){
                                lesson2Text.text = name
                            }else if(time == 3){
                                lesson3Text.text = name
                            }else if(time == 4){
                                lesson4Text.text = name
                            }else if(time == 5){
                                lesson5Text.text = name
                            }else if(time == 6){
                                lesson6Text.text = name
                            }else if(time == 7){
                                lesson7Text.text = name
                            }else if(time == 8){
                                lesson8Text.text = name
                            }
                        }
                    }
                }
            }
        }catch{
            print("Hata: Veri çekilemedi.")
        }
    }
    
    func isThisRowFull(time:Int, day:String)->Bool{
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Lessons")
        fetchRequest.predicate = NSPredicate(format: "lesson_day == %@ AND lesson_time == %d", day, time)
        
        do{
            let lesson = try context.fetch(fetchRequest)
            if (lesson.count == 0){
                return false
            }
        }catch{
            print("Hata: Veri çekilemedi.")
        }
        return true
    }
    
    func createNewLesson(name:String, time:Int, day:String){
        
        var flag = false
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Lessons")
        fetchRequest.predicate = NSPredicate(format: "lesson_day == %@ AND lesson_time == %d", day, time)
        
        do{
            let lesson = try context.fetch(fetchRequest)
            if (lesson.count == 0){
                flag = true
            }else{
                let ls = lesson[0]
                ls.setValue(name, forKey: "lesson_name")
                
                do{
                    try context.save()
                }catch{
                    print("Hata: Veri kaydedilemedi.")
                }
                //appDelegate.saveContext()
            }
        }catch{
            print("Hata: Veri çekilemedi.")
        }
        
        if (flag == true){
            if let entity = NSEntityDescription.entity(forEntityName: "Lessons", in: context){
            
                let lesson = NSManagedObject(entity: entity, insertInto: context)
                lesson.setValue(day, forKey: "lesson_day")
                lesson.setValue(name, forKey: "lesson_name")
                lesson.setValue(time, forKey: "lesson_time")
                
                do{
                    try context.save()
                }catch{
                    print("Hata: Veri kaydedilemedi.")
                }
            }
        }
    }
}
