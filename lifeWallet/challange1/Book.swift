//
//  Book.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Book{
    
    var book_id:Int?
    var user_id:Int?
    var book_name:String?
    var book_page:Int?
    var date:String?
    
    init() {}
    
    init(book_id: Int? = nil, user_id: Int? = nil, book_name: String? = nil, book_page: Int? = nil, date: String? = nil) {
        self.book_id = book_id
        self.user_id = user_id
        self.book_name = book_name
        self.book_page = book_page
        self.date = date
    }
}
