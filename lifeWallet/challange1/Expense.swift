//
//  Expense.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Expense{
    
    var expense_id:Int?
    var team_id:Int?
    var user_id:Int?
    var expense_description:String?
    var expense:Float?
    var date:String?
    
    init(){}
    
    init(expense_id: Int? = nil, team_id: Int? = nil, user_id: Int? = nil, expense_description: String? = nil, expense: Float? = nil, date: String? = nil) {
        self.expense_id = expense_id
        self.team_id = team_id
        self.user_id = user_id
        self.expense_description = expense_description
        self.expense = expense
        self.date = date
    }
}
