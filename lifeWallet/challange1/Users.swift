//
//  Users.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Users{
    
    var user_id:Int?
    var user_email:String?
    var user_username:String?
    var user_password:String?
    
    init(){}
    
    init(user_id: Int? = nil, user_email: String? = nil, user_username: String? = nil, user_password: String? = nil) {
        self.user_id = user_id
        self.user_email = user_email
        self.user_username = user_username
        self.user_password = user_password
    }
}
