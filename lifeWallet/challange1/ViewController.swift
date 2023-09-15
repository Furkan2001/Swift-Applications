//
//  ViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 29.08.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate // App delegate nesnesi tanımlanır

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyDatabase() //Veritabanı kopyalanmadıysa kopyalar..

    }

    func copyDatabase(){
        let bundlePath = Bundle.main.path(forResource: "ForFuture", ofType: ".db")
        
        let goalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let placeForCopy = URL(filePath: goalPath).appending(path: "ForFuture.db")
        
        if fileManager.fileExists(atPath: placeForCopy.path()){
            print("veritabanı zaten var!!")
        }else{
            do {
                try fileManager.copyItem(atPath: bundlePath!, toPath: placeForCopy.path)
            } catch {
                print(error)
            }
        }
    }
    
    
}

