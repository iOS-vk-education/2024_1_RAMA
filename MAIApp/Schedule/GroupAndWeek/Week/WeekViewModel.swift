//
//  WeekViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 26.03.2025.
//

import Foundation
class WeekViewModel: ObservableObject {
    @Published var selectedWeek: Int = 0
    @Published var selectedDate: Date = Date()
    @Published private(set) var allWeeks: [WeekData] = []
    @Published private(set) var groupSchedule: GroupSchedule?
    @Published private(set) var isLoading = false
    private var dataTask: URLSessionDataTask?
    private let scheduleManager: ScheduleManagerDescription
    
    init(
        scheduleManager: ScheduleManagerDescription
    ) {
        self.scheduleManager = scheduleManager
    }
    
    var selectedWeekRange: String {
        allWeeks.first { $0.number == selectedWeek }?.displayText ?? "Не выбрана"
    }
    
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.locale = Locale(identifier: "ru_RU")
        cal.firstWeekday = 2
        return cal
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    func getWeekNumber(from date: Date = Date()) -> Int {
        let calendar = Calendar.current
        return calendar.component(.weekOfYear, from: date) - 1
    }
    
    func loadWeeks(from schedule: GroupSchedule) {
        let dates = schedule.schedule.keys.compactMap { dateFormatter.date(from: $0) }
        
        let groupedDates = Dictionary(
            grouping: dates,
            by: { calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: $0) }
        )
        
        var weeks: [WeekData] = []
        
        for (components, datesInGroup) in groupedDates {
            guard let startDate = calendar.date(from: components),
                  let endDate = calendar.date(byAdding: .day, value: 6, to: startDate) else { continue }
            
            let weekDates = (0..<7).compactMap {
                calendar.date(byAdding: .day, value: $0, to: startDate)
            }
            
            let weekNumber = components.weekOfYear ?? 0
            let weekData = WeekData(
                number: weekNumber,
                startDate: startDate,
                endDate: endDate,
                dates: weekDates
            )
            
            weeks.append(weekData)
        }
        
        DispatchQueue.main.async {
            self.allWeeks = weeks.sorted { $0.startDate < $1.startDate }
            self.selectedWeek = self.allWeeks.first?.number ?? 0
            self.selectedDate = self.allWeeks.first?.startDate ?? Date()
        }
    }
    
    
    
    // MARK: - Public Methods
    func loadWeeksForGroup(for group: String) {
        Task(priority: .high) { @MainActor in
            defer {
                isLoading = false
            }
            
            isLoading = true
            let schedule = try await scheduleManager.loadSchedule(for: group)
            //            self.groupSchedule = schedule
            self.loadWeeks(from: schedule)
        }
    }
    
}
