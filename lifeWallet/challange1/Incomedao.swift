//
//  Incomedao.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Incomedao{
    
    let db:FMDatabase?
    
    init() {
        let goalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(filePath: goalPath).appending(path: "ForFuture.db")
        
        db = FMDatabase(path: databaseUrl.path())
    }
    
    func addNewIncome(team_id:Int, user_id:Int, income_description:String, income:Float, date:String){
        
        db?.open()
        
        do{
            try db?.executeUpdate("INSERT INTO Income (team_id, user_id, income_description, income, date) VALUES (?,?,?,?,?)", values: [team_id, user_id, income_description, income, date])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func readIncomes(team_id:Int, user_id:Int)->[Income]{
        
        var list = [Income]()
        
        db!.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Income WHERE team_id = ? AND user_id = ?", values: [team_id, user_id])
            
            while rs.next(){
                let income = Income()
                income.income_id = Int(rs.string(forColumn: "income_id")!)
                income.team_id = Int(rs.string(forColumn: "team_id")!)
                income.user_id = Int(rs.string(forColumn: "user_id")!)
                income.income_description = rs.string(forColumn: "income_description")
                income.income = Float(rs.string(forColumn: "income")!)
                income.date = rs.string(forColumn: "date")
                
                list.append(income)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return list
    }
    
    func searchTheWordInDescription(text:String, team_id:Int)->[Income]{
        
        var list = [Income]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Income WHERE team_id = ? AND income_description LIKE ?", values: [team_id, "%\(text)%"])

            
            while(rs.next()){
                let temp = Income()
                temp.income_id = Int(rs.string(forColumn: "income_id")!)
                temp.team_id = Int(rs.string(forColumn: "team_id")!)
                temp.user_id = Int(rs.string(forColumn: "user_id")!)
                temp.income_description = rs.string(forColumn: "income_description")
                temp.income = Float(rs.string(forColumn: "income")!)
                temp.date = rs.string(forColumn: "date")
                
                list.append(temp)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func readIncomesInLastMonth(team_id:Int, month:Int, year:Int)->[Income]{
        
        var list = [Income]()
        var time = String()
        
        if (month < 10){
            time = "/0\(month)/\(year)"
        }else{
            time = "/\(month)/\(year)"
        }
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Income WHERE team_id = ? AND date LIKE ?", values: [team_id, "%\(time)%"])

            
            while(rs.next()){
                let temp = Income()
                temp.income_id = Int(rs.string(forColumn: "income_id")!)
                temp.team_id = Int(rs.string(forColumn: "team_id")!)
                temp.user_id = Int(rs.string(forColumn: "user_id")!)
                temp.income_description = rs.string(forColumn: "income_description")
                temp.income = Float(rs.string(forColumn: "income")!)
                temp.date = rs.string(forColumn: "date")
                
                list.append(temp)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func removeAnIncome(id:Int){
        
        db?.open()
        
        do{
            try db?.executeUpdate("DELETE FROM Income WHERE income_id = ?", values: [id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
