//
//  Income.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Income{
    
    var income_id:Int?
    var team_id:Int?
    var user_id:Int?
    var income_description:String?
    var income:Float?
    var date:String?
    
    init(){}
    
    init(income_id: Int? = nil, team_id: Int? = nil, user_id: Int? = nil, income_description: String? = nil, income: Float? = nil, date: String? = nil) {
        self.income_id = income_id
        self.team_id = team_id
        self.user_id = user_id
        self.income_description = income_description
        self.income = income
        self.date = date
    }
}
