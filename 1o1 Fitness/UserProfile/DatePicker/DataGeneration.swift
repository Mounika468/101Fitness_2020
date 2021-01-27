//
//  Generation.swift
//  WeekdayPicker
//
//  Created by Maxime Le Coat on 07/03/2018.
//  Copyright © 2018 Maxime Le Coat. All rights reserved.
//

import UIKit

// MARK: - Data generation
extension WeekdayPicker {
    
    /// Generate list of days numbers.
    internal func dayList() -> [String] {
        return (1...31).map { $0.toString() }
    }
    
    /// Get list of days starting by monday
    internal func weekdayList() -> [String] {
        let numDays: Int = self.calendar.weekdaySymbols.count
        let first: Int = self.calendar.firstWeekday - 1
        let end: Int = first + numDays - 1
        return (first...end).map { self.calendar.shortWeekdaySymbols[$0 % numDays] }
    }
    
    /// Genrate day number for given month and year
    internal func dayList(month: Int, year: Int) -> [String] {
        if let currentYear: Int = Int(self.years.first ?? 0.toString()) {
            let nbDays: Int = self.numberOfDay(month: month + 1, year: year + currentYear)
            var tmpList: [String] = [String]()
            for index in 1...nbDays {
                tmpList.append(index.toString())
            }
            return tmpList
        }
        return [String]()
    }
    
    /// Get list of months
    internal func monthList() -> [String] {
        return self.dateFormatter.shortMonthSymbols
    }
    
    /// Get year list
    internal func yearList() -> [String] {
        
        
        
        let monthsToAdd = 0
                         let daysToAdd = 0
                         let yearsToAdd = -80
                         let currentDate = Date()
                  
                         var dateComponent = DateComponents()
                         
                         dateComponent.month = monthsToAdd
                         dateComponent.day = daysToAdd
                         dateComponent.year = yearsToAdd
                         
                         let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
                         
                         print(currentDate)
                         print(futureDate!)
        
        
        
        if let currentYear = self.calendar.dateComponents([.year], from: futureDate!).year {
            var tmpList: [String] = [String]()
            for current in currentYear...(currentYear + 80) {
                tmpList.append(current.toString())
            }
            return tmpList
        }
        return [String]()
    }
}
