import SwiftUI

struct ChooseWeekView: View {
    @Binding var weekNumber: Int
    @Binding var selectedDay: Date
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            NavigationStack {
                ScrollViewReader { placement in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(allWeeksInYear(), id: \.number) { week in
                                OneWeekView(
                                    week: week.displayText,
                                    isSelected: week.number == weekNumber
                                )
                                .id(week.number)
                                .onTapGesture {
                                    weekNumber = week.number
                                    selectedDay = week.startDate
                                    dismiss()
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Неделя")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        DispatchQueue.main.async {
                            placement.scrollTo(weekNumber, anchor: .center)
                        }
                    }
                }
            }
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
    
    
    //                    ForEach(Array(allWeeksInYear().enumerated()), id: \.element) { index, week in
    //                        OneWeekView(week: week)
    //                            .onTapGesture {
    //                                weekNumber = index + 1
    //                                let days = daysOfWeek(for: weekNumber)
    //                                print("Выбрана неделя: \(weekNumber), первый день: \(days.first?.formatted() ?? "nil")")
    //                                if !days.isEmpty {
    //                                    selectedDay = days[0]
    //                                }
    //                                dismiss()
    //
    //                            }
    //                    }
    
//    func allWeeksInYear() -> [String] {
//        var calendar = Calendar.current
//        calendar.locale = Locale(identifier: "ru_RU")
//        calendar.firstWeekday = 2
//        
//        
//        
//        let currentYear = calendar.component(.year, from: Date())
//        var weeks: [String] = []
//        
//        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)) else {
//            return []
//        }
//        
//        var firstMonday = startOfYear
//        while calendar.component(.weekday, from: firstMonday) != calendar.firstWeekday {
//            firstMonday = calendar.date(byAdding: .day, value: 1, to: firstMonday)!
//        }
//        
//        var currentMonday = firstMonday
//        while calendar.component(.year, from: currentMonday) == currentYear {
//            let startDate = calendar.startOfDay(for: currentMonday)
//            
//            guard let endDate = calendar.date(byAdding: .day, value: 6, to: startDate) else {
//                break
//            }
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd.MM.YYYY"
//            
//            let startDateString = dateFormatter.string(from: startDate)
//            let endDateString = dateFormatter.string(from: endDate)
//            
//            // Добавляем строку в массив
//            weeks.append("\(startDateString) – \(endDateString)")
//            
//            // Переходим к следующей неделе
//            guard let nextMonday = calendar.date(byAdding: .day, value: 7, to: currentMonday) else {
//                break
//            }
//            currentMonday = nextMonday
//        }
//        
//        return weeks
//    }
    
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


