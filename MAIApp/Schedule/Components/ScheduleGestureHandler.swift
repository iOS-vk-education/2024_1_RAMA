import SwiftUI

struct ScheduleGestureHandler: ViewModifier {
    @ObservedObject var dateViewModel: DateViewModel
    let mode: ScheduleMode
    
    func body(content: Content) -> some View {
        content.gesture(
            DragGesture()
                .onEnded { value in
                    handleSwipe(value)
                }
        )
    }
    
    private func handleSwipe(_ value: DragGesture.Value) {
        guard abs(value.translation.width) > 30 else { return }
        
        let calendar = Calendar.current
        
        switch mode {
        case .day:
            handleDayModeSwipe(value, calendar: calendar)
        case .week:
            handleWeekModeSwipe(value, calendar: calendar)
//        case .calendar:
//            handleDayModeSwipe(value, calendar: calendar)
        }
    }
    
    private func handleDayModeSwipe(_ value: DragGesture.Value, calendar: Calendar) {
        let selected = dateViewModel.selectedDay
        let currentWeek = calendar.component(.weekOfYear, from: selected)
        
        let days = dateViewModel.daysOfWeek(for: currentWeek)
            .filter { calendar.component(.weekday, from: $0) != 1 } // исключаем воскресенье
        
        guard let index = days.firstIndex(where: { calendar.isDate($0, inSameDayAs: selected) }) else { return }
        
        withAnimation(.easeInOut(duration: 0.15)) {
            if value.translation.width < 0 {
                // свайп налево - идем вперед
                if index < days.count - 1 {
                    dateViewModel.selectedDay = days[index + 1]
                } else {
                    let nextWeek = currentWeek + 1
                    let nextDays = dateViewModel.daysOfWeek(for: nextWeek)
                        .filter { calendar.component(.weekday, from: $0) != 1 }
                    if let monday = nextDays.first {
                        dateViewModel.selectedWeek = nextWeek
                        dateViewModel.selectedDay = monday
                    }
                }
            } else {
                // свайп направо - идем назад
                if index > 0 {
                    dateViewModel.selectedDay = days[index - 1]
                } else {
                    let prevWeek = currentWeek - 1
                    let prevDays = dateViewModel.daysOfWeek(for: prevWeek)
                        .filter { calendar.component(.weekday, from: $0) != 1 }
                    if let saturday = prevDays.last {
                        dateViewModel.selectedWeek = prevWeek
                        dateViewModel.selectedDay = saturday
                    }
                }
            }
        }
    }
    
    private func handleWeekModeSwipe(_ value: DragGesture.Value, calendar: Calendar) {
        let currentWeek = dateViewModel.selectedWeek
        
        withAnimation(.easeInOut(duration: 0.15)) {
            if value.translation.width < 0 {
                // свайп налево - следующая неделя
                let nextWeek = currentWeek + 1
                dateViewModel.selectedWeek = nextWeek
                if let firstDay = dateViewModel.daysOfWeek(for: nextWeek).first(where: {
                    calendar.component(.weekday, from: $0) != 1
                }) {
                    dateViewModel.selectedDay = firstDay
                }
            } else {
                // свайп направо - предыдущая неделя
                let prevWeek = currentWeek - 1
                dateViewModel.selectedWeek = prevWeek
                if let firstDay = dateViewModel.daysOfWeek(for: prevWeek).first(where: {
                    calendar.component(.weekday, from: $0) != 1
                }) {
                    dateViewModel.selectedDay = firstDay
                }
            }
        }
    }
}

extension View {
    func scheduleGesture(dateViewModel: DateViewModel, mode: ScheduleMode) -> some View {
        modifier(ScheduleGestureHandler(dateViewModel: dateViewModel, mode: mode))
    }
} 
