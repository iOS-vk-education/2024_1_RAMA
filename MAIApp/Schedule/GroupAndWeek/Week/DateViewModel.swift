//
//  WeekViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 26.03.2025.
//

import Foundation
import Combine

class DateViewModel: ObservableObject {
    @Published var selectedWeek: Int = Calendar.current.component(.weekOfYear, from: Date())
    @Published var selectedDay: Date = Date()
    @Published var isSelectedDay: Bool = false
    @Published private(set) var allWeeks: [WeekData] = []
    @Published private(set) var groupSchedule: GroupSchedule?
    @Published private(set) var isLoading = false

    private var dataTask: URLSessionDataTask?
    private let scheduleManager: ScheduleManagerProtocol
    private var cancellables = Set<AnyCancellable>()

    init(scheduleManager: ScheduleManagerProtocol) {
        self.scheduleManager = scheduleManager
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

    var selectedWeekRange: String {
        allWeeks.first { $0.number == selectedWeek }?.displayText ?? "Не выбрана"
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

        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: firstDayOfWeek)
        }
    }

    public func updateSelectedDayForWeek(_ weekNumber: Int) {
        let currentWeek = Calendar.current.component(.weekOfYear, from: Date())

        if weekNumber == currentWeek {
            selectedDay = Date()
        } else {
            if let weekData = allWeeks.first(where: { $0.number == weekNumber }) {
                selectedDay = weekData.startDate
            } else {
                let calendar = Calendar.current
                var components = DateComponents()
                components.year = calendar.component(.year, from: Date())
                components.weekOfYear = weekNumber
                components.weekday = calendar.firstWeekday

                if let mondayDate = calendar.date(from: components) {
                    selectedDay = mondayDate
                }
            }
        }

        isSelectedDay = true
    }

    func loadWeeks(from schedule: GroupSchedule) {
        let dates = schedule.schedule.keys.compactMap { dateFormatter.date(from: $0) }

        let groupedDates = Dictionary(
            grouping: dates,
            by: { calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: $0) }
        )

        var weeks: [WeekData] = []

        for (components, _) in groupedDates {
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
            self.updateSelectedDayForWeek(self.selectedWeek)
        }
    }

    @MainActor
    func loadWeeksForGroup(for group: String) {
        Task(priority: .high) { [weak self] in
            guard let self else { return }
            defer { isLoading = false }

            isLoading = true
            let schedule = try await scheduleManager.loadSchedule(for: group)
            self.loadWeeks(from: schedule)
        }
    }
}
