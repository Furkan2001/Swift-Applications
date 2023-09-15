//
//  Filmdao.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Filmdao{
    
    let db:FMDatabase?
    
    init() {
        let goalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(filePath: goalPath).appending(path: "ForFuture.db")
        
        db = FMDatabase(path: databaseUrl.path())
    }
    
    func addNewFilm(user_id:Int, film_type_id:Int, film_name:String, film_time:Int, date:String){
        
        db?.open()
        
        do{
            try db?.executeUpdate("INSERT INTO Film (user_id, film_type_id, film_name, film_time, date) VALUES (?,?,?,?,?)", values: [user_id, film_type_id, film_name, film_time, date])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func readFilms(user_id:Int)->[Film]{
        
        var list = [Film]()
        
        db!.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Film WHERE user_id = ?", values: [user_id])
            
            while rs.next(){
                let film = Film()
                film.film_id = Int(rs.string(forColumn: "film_id")!)
                film.user_id = Int(rs.string(forColumn: "user_id")!)
                film.film_name = rs.string(forColumn: "film_name")
                film.film_type_id = Int(rs.string(forColumn: "film_type_id")!)
                film.film_time = Int(rs.string(forColumn: "film_time")!)
                film.date = rs.string(forColumn: "date")
                
                list.append(film)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return list
    }
    
    func searchTheWordInName(text:String, user_id:Int)->[Film]{
        
        var list = [Film]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Film WHERE user_id = ? AND film_name LIKE ?", values: [user_id, "%\(text)%"])

            
            while(rs.next()){
                let temp = Film()
                temp.film_id = Int(rs.string(forColumn: "film_id")!)
                temp.user_id = Int(rs.string(forColumn: "user_id")!)
                temp.film_name = rs.string(forColumn: "film_name")
                temp.film_type_id = Int(rs.string(forColumn: "film_type_id")!)
                temp.film_time = Int(rs.string(forColumn: "film_time")!)
                temp.date = rs.string(forColumn: "date")
                
                list.append(temp)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func readFilmInLastMonth(month:Int, year:Int, user_id:Int)->[Film]{
        var list = [Film]()
        
        var time = String()
        
        if (month < 10){
            time = "/0\(month)/\(year)"
        }else{
            time = "/\(month)/\(year)"
        }
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Film WHERE user_id = ? AND date LIKE ?", values: [user_id, "%\(time)%"])

            
            while(rs.next()){
                let temp = Film()
                temp.film_id = Int(rs.string(forColumn: "film_id")!)
                temp.user_id = Int(rs.string(forColumn: "user_id")!)
                temp.film_name = rs.string(forColumn: "film_name")
                temp.film_type_id = Int(rs.string(forColumn: "film_type_id")!)
                temp.film_time = Int(rs.string(forColumn: "film_time")!)
                temp.date = rs.string(forColumn: "date")
                
                list.append(temp)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func removeAFilm(id:Int){
        
        db?.open()
        
        do{
            try db?.executeUpdate("DELETE FROM Film WHERE film_id = ?", values: [id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
