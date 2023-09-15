//
//  Expensedao.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Expensedao{
    
    let db:FMDatabase?
    
    init() {
        let goalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(filePath: goalPath).appending(path: "ForFuture.db")
        
        db = FMDatabase(path: databaseUrl.path())
    }
    
    func addNewExpense(team_id:Int, user_id:Int, expense_description:String, expense:Float, date:String){
        
        db?.open()
        
        do{
            try db?.executeUpdate("INSERT INTO Expense (team_id, user_id, expense_description, expense, date) VALUES (?,?,?,?,?)", values: [team_id, user_id, expense_description, expense, date])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func readExpenses(team_id:Int, user_id:Int)->[Expense]{
        
        var list = [Expense]()
        
        db!.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Expense WHERE team_id = ? AND user_id = ?", values: [team_id, user_id])
            
            while rs.next(){
                let expense = Expense()
                expense.expense_id = Int(rs.string(forColumn: "expense_id")!)
                expense.team_id = Int(rs.string(forColumn: "team_id")!)
                expense.user_id = Int(rs.string(forColumn: "user_id")!)
                expense.expense_description = rs.string(forColumn: "expense_description")
                expense.expense = Float(rs.string(forColumn: "expense")!)
                expense.date = rs.string(forColumn: "date")
                
                list.append(expense)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return list
    }
    
    func searchTheWordInDescription(text:String, team_id:Int)->[Expense]{
        
        var list = [Expense]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Expense WHERE team_id = ? AND expense_description LIKE ?", values: [team_id, "%\(text)%"])

            
            while(rs.next()){
                let temp = Expense()
                temp.expense_id = Int(rs.string(forColumn: "expense_id")!)
                temp.team_id = Int(rs.string(forColumn: "team_id")!)
                temp.user_id = Int(rs.string(forColumn: "user_id")!)
                temp.expense_description = rs.string(forColumn: "expense_description")
                temp.expense = Float(rs.string(forColumn: "expense")!)
                temp.date = rs.string(forColumn: "date")
                
                list.append(temp)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func readExpensesInLastMonth(month:Int, year:Int, team_id:Int)->[Expense]{
        
        var list = [Expense]()
        var time = String()
        
        if (month < 10){
            time = "/0\(month)/\(year)"
        }else{
            time = "/\(month)/\(year)"
        }
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Expense WHERE team_id = ? AND date LIKE ?", values: [team_id, "%\(time)%"])

            while(rs.next()){
                let temp = Expense()
                temp.expense_id = Int(rs.string(forColumn: "expense_id")!)
                temp.team_id = Int(rs.string(forColumn: "team_id")!)
                temp.user_id = Int(rs.string(forColumn: "user_id")!)
                temp.expense_description = rs.string(forColumn: "expense_description")
                temp.expense = Float(rs.string(forColumn: "expense")!)
                temp.date = rs.string(forColumn: "date")
                
                list.append(temp)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func removeAnExpense(id:Int){
        
        db?.open()
        
        do{
            try db?.executeUpdate("DELETE FROM Expense WHERE expense_id = ?", values: [id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
