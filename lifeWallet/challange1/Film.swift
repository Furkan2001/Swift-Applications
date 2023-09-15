//
//  Film.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Film{
    
    var film_id:Int?
    var user_id:Int?
    var film_type_id:Int?
    var film_name:String?
    var film_time:Int?
    var date:String?
    
    init(){}
    
    init(film_id: Int? = nil, user_id: Int? = nil, film_type_id: Int? = nil, film_name: String? = nil, film_time: Int? = nil, date: String? = nil) {
        self.film_id = film_id
        self.user_id = user_id
        self.film_type_id = film_type_id
        self.film_name = film_name
        self.film_time = film_time
        self.date = date
    }
}
