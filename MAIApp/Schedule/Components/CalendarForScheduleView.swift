import SwiftUI

struct CalendarForScheduleView: View {
    @ObservedObject var dateViewModel: DateViewModel
    @Environment(\.colorScheme) var colorScheme
    
    private let calendar = Calendar.current
    private let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    
    var body: some View {
        VStack(spacing: 20) {
            // Месяц и год
            HStack {
                Text(monthYearString(from: dateViewModel.selectedDay))
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal)
            
            // Дни недели
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                }
            }
            
            // Сетка календаря
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(daysInMonth(), id: \.self) { date in
                    if let date = date {
                        DayCell(date: date, isSelected: calendar.isDate(date, inSameDayAs: dateViewModel.selectedDay))
                            .onTapGesture {
                                withAnimation {
                                    dateViewModel.selectedDay = date
                                }
                            }
                    } else {
                        Color.clear
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.cardBackground)
        )
    }
    
    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date).capitalized
    }
    
    private func daysInMonth() -> [Date?] {
        let interval = calendar.dateInterval(of: .month, for: dateViewModel.selectedDay)!
        let firstDay = interval.start
        
        // Получаем день недели для первого дня месяца (1 = воскресенье, 2 = понедельник, ...)
        var firstWeekday = calendar.component(.weekday, from: firstDay)
        // Преобразуем в наш формат (1 = понедельник, 7 = воскресенье)
        firstWeekday = firstWeekday == 1 ? 7 : firstWeekday - 1
        
        // Добавляем пустые ячейки для выравнивания
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        
        // Добавляем дни месяца
        let daysInMonth = calendar.range(of: .day, in: .month, for: firstDay)!.count
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }
        
        return days
    }
}

struct DayCell: View {
    let date: Date
    let isSelected: Bool
    
    private let calendar = Calendar.current
    
    var body: some View {
        Text("\(calendar.component(.day, from: date))")
            .font(.system(size: 16))
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(
                Circle()
                    .fill(isSelected ? Color.customBlue : Color.clear)
            )
            .foregroundColor(isSelected ? .white : .primary)
    }
} 
