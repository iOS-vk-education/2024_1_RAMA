import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDay: Date
    @Binding var weekNumber: Int
    @Namespace private var animationNamespace
    @Environment(\.colorScheme) var colorScheme
    
    var weekDates: [Date] {
        daysOfWeek(for: weekNumber + 1)
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6) { i in
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedDay = weekDates[i]
                    }
                } ) {
                DayView(
                    day: weekDates[i], index: i, isActive: Calendar.current.isDate(selectedDay, inSameDayAs: weekDates[i]), namespace: animationNamespace
                                    )
                                }
                .foregroundColor(.primary)
            }
        }
        .onAppear {
            print("📱 DatePickerView появился, selectedDay: \(selectedDay), weekNumber: \(weekNumber)")
        }
        .frame(maxWidth: .infinity)
        .padding(2)
        .fixedSize(horizontal: false, vertical: true)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    

    private func daysOfWeek(for weekNumber: Int) -> [Date] {
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
}


#Preview {
    DatePickerView(selectedDay: .constant(Date()), weekNumber: .constant(52))
}
