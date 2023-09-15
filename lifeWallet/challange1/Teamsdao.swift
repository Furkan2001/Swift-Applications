//
//  Teamsdao.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Teamsdao{
    
    let db:FMDatabase?
    
    init() {
        let goalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(filePath: goalPath).appending(path: "ForFuture.db")
        
        db = FMDatabase(path: databaseUrl.path())
    }
    
    func addNewUser(user_id:Int, team_name:String, team_type_id:Int){
        
        db?.open()
        
        do{
            try db?.executeUpdate("INSERT INTO Teams (user_id, team_name, team_type_id) VALUES (?,?,?)", values: [user_id, team_name, team_type_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func returnTeamsInId(id:Int)->[Teams]{
        
        var list = [Teams]()
        
        db!.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Teams WHERE user_id = ?", values: [id])
            
            while rs.next(){
                let team = Teams()
                team.team_id = Int(rs.string(forColumn: "team_id")!)!
                team.user_id = Int(rs.string(forColumn: "user_id")!)!
                team.team_name = rs.string(forColumn: "team_name")
                team.team_type_id = Int(rs.string(forColumn: "team_type_id")!)!
                
                list.append(team)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return list
    }
    
    func removeElement(whereId: Int){
        
        db?.open()
        
        do{
            try db?.executeUpdate("DELETE FROM Teams WHERE team_id = ?", values: [whereId])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
