//
//  ViewController.swift
//  FourOperations
//
//  Created by Furkan Ekinci on 12.09.2023.
//

import UIKit
import CoreData

var score:Int?
var time:Int?

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewcontroller did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewcontroller will appear")
        score = 0
        time = 90
        
        if UserDefaults.standard.object(forKey: "score") == nil {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(0, forKey: "score")
        }
    }
}

