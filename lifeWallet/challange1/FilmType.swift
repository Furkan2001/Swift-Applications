//
//  FilmType.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class FilmType{
    
    var type_id:Int?
    var type_name:String?
    
    init(){}
    
    init(type_id: Int? = nil, type_name: String? = nil) {
        self.type_id = type_id
        self.type_name = type_name
    }
}
