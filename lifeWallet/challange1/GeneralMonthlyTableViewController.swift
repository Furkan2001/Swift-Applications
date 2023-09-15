//
//  GeneralMonthlyTableViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 11.09.2023.
//

import UIKit

final class GeneralMonthlyTableViewController: UIViewController {
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var profitAndLostAmountLabel: UILabel!
    @IBOutlet weak var howManyBooks: UITextView!
    @IBOutlet weak var howManyBooksInLastMonth: UITextView!
    @IBOutlet weak var howManyFilms: UITextView!
    @IBOutlet weak var howManyFilmsInLastMonth: UITextView!
    
    private var listIncome                  = [Income]()
    private var listExpense                 = [Expense]()
    private var listOfBooks                 = [Book]()
    private var listOfWatchings             = [Film]()
    private var listOfBooksForLastMonth     = [Book]()
    private var listOfWatchingsForLastMonth = [Film]()
    
    private var month       = 0
    private var year        = 0
    private var lastMonth   = 0
    private var lastYear    = 0
    
    private var profitOrLost = 0
    private var sumOfBookForThisMonth = 0
    private var sumOfBookForLastMonth = 0
    private var sumOfFilmForThisMonth = 0
    private var sumOfFilmForLastMonth = 0
    private var amountOfBookForThisMonth = 0
    private var amountOfBookForLastMonth = 0
    private var timeOfFilmForThisMonth = 0
    private var timeOfFilmForLastMonth = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let today = Date() // Şu anki tarihi al
        let calendar = Calendar.current // Geçerli takvimi al

        month = calendar.component(.month, from: today) // Ayı elde et
        year = calendar.component(.year, from: today)
        
        if (month == 1){
            lastMonth = 12
            lastYear = year - 1
        }else{
            lastMonth = month - 1
            lastYear = year
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        listIncome = Incomedao().readIncomesInLastMonth(team_id: UserDefaults.standard.integer(forKey: "team_id"), month: month, year: year)
        listExpense = Expensedao().readExpensesInLastMonth(month: month, year: year, team_id: UserDefaults.standard.integer(forKey: "team_id"))
        listOfBooks = Bookdao().readBooksInLastMonth(user_id: UserDefaults.standard.integer(forKey: "user_id"), month: month, year: year)
        listOfWatchings = Filmdao().readFilmInLastMonth(month: month, year: year, user_id: UserDefaults.standard.integer(forKey: "user_id"))
        listOfBooksForLastMonth = Bookdao().readBooksInLastMonth(user_id: UserDefaults.standard.integer(forKey: "user_id"), month: lastMonth, year: lastYear)
        listOfWatchingsForLastMonth = Filmdao().readFilmInLastMonth(month: lastMonth, year: lastYear, user_id: UserDefaults.standard.integer(forKey: "user_id"))
        
        for income in listIncome{
            self.profitOrLost += Int(income.income!)
        }
        for expense in listExpense{
            self.profitOrLost -= Int(expense.expense!)
        }
        
        if (profitOrLost > 0){
            resultLabel.text = "KAZANÇ"
            resultLabel.backgroundColor = UIColor.green
            profitAndLostAmountLabel.text = "Bu ay \(profitOrLost) TL kârdasın :)"
        }else if(profitOrLost == 0){
            resultLabel.text = "SINIR"
            resultLabel.backgroundColor = UIColor.gray
            profitAndLostAmountLabel.text = "Bu ay kâr zarar durumun yok"
        }else{
            resultLabel.text = "KAYIP"
            resultLabel.backgroundColor = UIColor.red
            profitAndLostAmountLabel.text = "Bu ay \(profitOrLost) TL zarardasın :("
        }
        
        sumOfBookForThisMonth = listOfBooks.count
        sumOfBookForLastMonth = listOfBooksForLastMonth.count
        
        for book in listOfBooks{
            amountOfBookForThisMonth += book.book_page!
        }
        
        for book in listOfBooksForLastMonth{
            amountOfBookForLastMonth += book.book_page!
        }
        
        howManyBooks.text = "Bu ay \(sumOfBookForThisMonth) adet kitap okudun. Bu kitaplar toplam \(amountOfBookForThisMonth) sayfaydı."
        
        howManyBooksInLastMonth.text = "Geçen ay \(sumOfBookForLastMonth) adet kitap okumuştun. Bu kitaplar toplam \(amountOfBookForLastMonth) sayfaydı."
        
        sumOfFilmForThisMonth = listOfWatchings.count
        sumOfFilmForLastMonth = listOfWatchingsForLastMonth.count
        
        for film in listOfWatchings{
            timeOfFilmForThisMonth += film.film_time!
        }
        
        for film in listOfWatchingsForLastMonth{
            timeOfFilmForLastMonth += film.film_time!
        }
        
        howManyFilms.text = "Bu ay \(sumOfFilmForThisMonth) adet film izledin. Filmlerin toplam süresi \(timeOfFilmForThisMonth) dakikaydı."
        
        howManyFilmsInLastMonth.text = "Geçen ay \(sumOfFilmForLastMonth) adet film izlemiştin. Filmlerin toplam süresi \(timeOfFilmForLastMonth) dakikaydı."
    }

}
