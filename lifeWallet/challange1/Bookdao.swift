//
//  Bookdao.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Bookdao{
    
    let db:FMDatabase?
    
    init() {
        let goalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(filePath: goalPath).appending(path: "ForFuture.db")
        
        db = FMDatabase(path: databaseUrl.path())
    }
    
    func addNewBook(user_id:Int, book_name:String, book_page:Int, date:String){
        
        db?.open()
        
        do{
            try db?.executeUpdate("INSERT INTO Book (user_id, book_name, book_page, date) VALUES (?,?,?,?)", values: [user_id, book_name, book_page, date])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func readBooks(user_id:Int)->[Book]{
        
        var list = [Book]()
        
        db!.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Book WHERE user_id = ?", values: [user_id])
            
            while rs.next(){
                let book = Book()
                book.book_id = Int(rs.string(forColumn: "book_id")!)
                book.user_id = Int(rs.string(forColumn: "user_id")!)
                book.book_name = rs.string(forColumn: "book_name")
                book.book_page = Int(rs.string(forColumn: "book_page")!)
                book.date = rs.string(forColumn: "date")
                
                list.append(book)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return list
    }
    
    func searchTheWordInDescription(text:String, user_id:Int)->[Book]{
        
        var list = [Book]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Book WHERE user_id = ? AND book_name LIKE ?", values: [user_id, "%\(text)%"])

            
            while(rs.next()){
                let temp = Book()
                temp.book_id = Int(rs.string(forColumn: "book_id")!)
                temp.user_id = Int(rs.string(forColumn: "user_id")!)
                temp.book_name = rs.string(forColumn: "book_name")
                temp.book_page = Int(rs.string(forColumn: "book_page")!)
                temp.date = rs.string(forColumn: "date")
                
                list.append(temp)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func readBooksInLastMonth(user_id:Int, month:Int, year:Int)->[Book]{
        var list = [Book]()
        
        var time = String()
        
        if (month < 10){
            time = "/0\(month)/\(year)"
        }else{
            time = "/\(month)/\(year)"
        }
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Book WHERE user_id = ? AND date LIKE ?", values: [user_id, "%\(time)%"])

            
            while(rs.next()){
                let temp = Book()
                temp.book_id = Int(rs.string(forColumn: "book_id")!)
                temp.user_id = Int(rs.string(forColumn: "user_id")!)
                temp.book_name = rs.string(forColumn: "book_name")
                temp.book_page = Int(rs.string(forColumn: "book_page")!)
                temp.date = rs.string(forColumn: "date")
                
                list.append(temp)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func removeABook(id:Int){
        
        db?.open()
        
        do{
            try db?.executeUpdate("DELETE FROM Book WHERE book_id = ?", values: [id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
