//
//  WeekViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 26.03.2025.
//

import Foundation

final class WeekViewModel: ObservableObject {
    func weekRange(for weekNumber: Int) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.firstWeekday = 2 //понедельник как первый день недели
        
        let currentYear = calendar.component(.year, from: Date())
        
        //1 января текущего года
        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)) else {
            return ""
        }
        
        //первый понедельник года
        var firstMonday = startOfYear
        while calendar.component(.weekday, from: firstMonday) != calendar.firstWeekday {
            firstMonday = calendar.date(byAdding: .day, value: 1, to: firstMonday)!
        }
        
        //переходим к нужной неделе
        let daysToAdd = (weekNumber - 1) * 7
        guard let startOfWeek = calendar.date(byAdding: .day, value: daysToAdd, to: firstMonday) else {
            return ""
        }
        
        //конец недели (воскресенье)
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            return ""
        }
        
        //форматирование даты
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        let startDateString = dateFormatter.string(from: startOfWeek)
        let endDateString = dateFormatter.string(from: endOfWeek)
        
        return "\(startDateString) – \(endDateString)"
    }
    
    func allWeeksInYear() -> [WeekData] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.firstWeekday = 2
        
        let currentYear = calendar.component(.year, from: Date())
        var weeks: [WeekData] = []
        
        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)) else {
            return []
        }
        
        var firstMonday = startOfYear
        while calendar.component(.weekday, from: firstMonday) != calendar.firstWeekday {
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: firstMonday) else { break }
            firstMonday = nextDay
        }
        
        var currentMonday = firstMonday
        var weekNumber = 1
        
        while calendar.component(.year, from: currentMonday) == currentYear {
            guard let endDate = calendar.date(byAdding: .day, value: 6, to: currentMonday) else { break }
            
            let week = WeekData(
                number: weekNumber,
                startDate: currentMonday,
                endDate: endDate
            )
            
            weeks.append(week)
            weekNumber += 1
            
            guard let nextMonday = calendar.date(byAdding: .weekOfYear, value: 1, to: currentMonday) else { break }
            currentMonday = nextMonday
        }
        
        return weeks
    }
    
    func daysOfWeek(for weekNumber: Int) -> [Date] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.firstWeekday = 2
        
        let currentYear = calendar.component(.year, from: Date())
        
        var components = DateComponents()
        components.year = currentYear
        components.weekOfYear = weekNumber
        components.weekday = calendar.firstWeekday
        
        guard let firstDayOfWeek = calendar.date(from: components) else {
            return []
        }
        
        return (0..<7).compactMap { i in
            calendar.date(byAdding: .day, value: i, to: firstDayOfWeek)
        }
    }

}
