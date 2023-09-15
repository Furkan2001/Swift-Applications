//
//  FilmTypedao.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class FilmTypedao{
    
    let db:FMDatabase?
    
    init() {
        let goalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(filePath: goalPath).appending(path: "ForFuture.db")
        
        db = FMDatabase(path: databaseUrl.path())
    }
    
    func selectAllElements()->[FilmType]{
        var list = [FilmType]()
        
        db!.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM FilmType", values: [])
            
            while rs.next(){
                let type = FilmType()
                type.type_id = Int(rs.string(forColumn: "type_id")!)!
                type.type_name = rs.string(forColumn: "type_name")
                
                list.append(type)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return list
    }
    
    func findTheIdFromName(name:String)->Int{
        
        var idOfFilm = 0
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM FilmType WHERE type_name = ?", values: [name])

            while(rs.next()){
                
                idOfFilm = Int(rs.string(forColumn: "type_id")!)!
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return idOfFilm
    }
    
    func findTheNameFromId(id:Int)->String{
        
        var stringOfFilm = String()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM FilmType WHERE type_id = ?", values: [id])

            while(rs.next()){
                
                stringOfFilm = rs.string(forColumn: "type_name")!
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return stringOfFilm
    }
}
