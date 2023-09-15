//
//  Usersdao.swift
//  challange1
//
//  Created by Furkan Ekinci on 6.09.2023.
//

import Foundation

final class Usersdao{
    
    let db:FMDatabase?
    
    init() {
        let goalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(filePath: goalPath).appending(path: "ForFuture.db")
        
        db = FMDatabase(path: databaseUrl.path())
    }
    
    func addNewUser(user_email:String, user_username:String, user_password:String){
        
        db?.open()
        
        do{
            try db?.executeUpdate("INSERT INTO Users (user_email, user_username, user_password) VALUES (?,?,?)", values: [user_email, user_username, user_password])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func readAllElements()->[Users]{
        
        var list = [Users]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Users", values: nil)
            
            while (rs.next()){
                let user = Users(user_id: Int((rs.string(forColumn: "user_id")!)), user_email: rs.string(forColumn: "user_email"), user_username:rs.string(forColumn: "user_username"), user_password:rs.string(forColumn: "user_password"))
                    
                list.append(user)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func didUseThisEmailBefore(email:String) -> Bool{
            
        var count = 0
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT count(*) as result FROM Users WHERE user_email = ?", values: [email])
            
            while rs.next(){
                count = Int(rs.string(forColumn: "result")!)!
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        if(count == 0){
            return false
        }else{
            return true
        }
    }
    
    func didUseThisUsernameBefore(username:String) -> Bool{
            
        var count = 0
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT count(*) as result FROM Users WHERE user_username = ?", values: [username])
            
            while rs.next(){
                count = Int(rs.string(forColumn: "result")!)!
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        if(count == 0){
            return false
        }else{
            return true
        }
    }
    
    func didThisUserRegisterBefore(username:String, password:String)->Bool{
        
        var count = 0
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT count(*) as result FROM Users WHERE user_username = ? AND user_password = ?", values: [username, password])
            
            while rs.next(){
                count = Int(rs.string(forColumn: "result")!)!
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        if(count == 0){
            return false
        }else{
            return true
        }
    }
    
    func enterUsernameFindUserId(username:String)->Int{
        var id = 0
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Users WHERE user_username = ?", values: [username])
            
            while rs.next(){
                id = Int(rs.string(forColumn: "user_id")!)!
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return id
    }
    
    func returnUserInUsername(username:String)->Users{
        
        let tempUser = Users()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM Users WHERE user_username = ?", values: [username])
            
            while rs.next(){
                tempUser.user_email = rs.string(forColumn: "user_email")!
                tempUser.user_id = Int(rs.string(forColumn: "user_id")!)!
                tempUser.user_username = rs.string(forColumn: "user_username")!
                tempUser.user_password = rs.string(forColumn: "user_password")!
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return tempUser
    }
    
    func updateUserInUsername(dummyUsername:String, email:String, username:String, password:String){
        
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE Users SET user_email = ? , user_username = ? , user_password = ? WHERE user_username = ?", values: [email, username, password, dummyUsername])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
