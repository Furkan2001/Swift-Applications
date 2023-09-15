//
//  Teams.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Teams{
    
    var team_id:Int?
    var user_id:Int?
    var team_name:String?
    var team_type_id:Int?
    
    init(){}
    
    init(team_id: Int? = nil, user_id: Int? = nil, team_name: String? = nil, team_type_id: Int? = nil) {
        self.team_id = team_id
        self.user_id = user_id
        self.team_name = team_name
        self.team_type_id = team_type_id
    }
}
