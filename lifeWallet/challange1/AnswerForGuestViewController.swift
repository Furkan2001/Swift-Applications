//
//  AnswerForGuestViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 29.08.2023.
//

import UIKit

final class AnswerForGuestViewController: UIViewController {


    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var explanation: UITextView!
    var text1 = ""
    var text2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answer.text = text1
        explanation.text = text2

    }
    

  

}
