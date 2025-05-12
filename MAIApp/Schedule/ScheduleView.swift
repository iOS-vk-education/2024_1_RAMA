import SwiftUI

struct ScheduleView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @ObservedObject var dateViewModel: DateViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject var lessonViewModel: LessonViewModel
    

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    @State private var scheduleMode: ScheduleMode = .day
    @State private var isMenuOpen = false

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                if groupSelectionViewModel.selectedGroup == "" {
                    
                    GroupAndWeekView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: dateViewModel)
                    
                    ErrorGroupView()
                    
                }
                
                else if scheduleMode == .day {
                    
                    GroupAndWeekView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: dateViewModel)
                    
                    DatePickerView(dateViewModel: dateViewModel)
                    ScheduleModeView(contentViewModel: contentViewModel)
                    LessonsView(
                        viewModel: lessonViewModel,
                        dateViewModel: dateViewModel,
                        groupSelectionViewModel: groupSelectionViewModel
                    )
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                guard abs(value.translation.width) > 50 else { return }

                                let calendar = Calendar.current
                                let selected = dateViewModel.selectedDay
                                let currentWeek = calendar.component(.weekOfYear, from: selected)

                                let days = dateViewModel.daysOfWeek(for: currentWeek)
                                    .filter { calendar.component(.weekday, from: $0) != 1 } // нафиг воскресенье

                                guard let index = days.firstIndex(where: { calendar.isDate($0, inSameDayAs: selected) }) else { return }

                                withAnimation(.easeInOut(duration: 0.15)) { // добавляем анимацию
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
                    )
                    
                    Spacer()
                    
                }
                
                
                else if scheduleMode == .week {
                    
                    GroupAndWeekView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: dateViewModel)
                
                    
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Расписание")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Избранное", destination: FavoritesScreen(groupSelectionViewModel: groupSelectionViewModel))
                        .onChange(of: groupSelectionViewModel.selectedGroup) {_, newGroup in
                            if !newGroup.isEmpty {
                                dateViewModel.loadWeeksForGroup(for: newGroup)
                            }
                        }
                    
//                    Menu {
//                        Picker("Режим", selection: $scheduleMode) {
//                            ForEach(ScheduleMode.allCases, id: \.self) { mode in
//                                HStack(spacing: 12) {
//                                    Image(iconName(for: mode))
//                                        .resizable()
//                                        .frame(width: 20, height: 20)
//                                    Text(mode.rawValue)
//                                }
//                                .tag(mode)
//                            }
//                        }
//                    } label: {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 15)
//                                .frame(width: 40, height: 40)
//                                .foregroundColor(isMenuOpen ? .blue : Color(.systemGray5))
//                            
//                            if isMenuOpen {
//                                Image(systemName: "xmark")
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 20, weight: .bold))
//                            } else {
//                                Image(iconName(for: scheduleMode))
//                                    .resizable()
//                                    .frame(width: 24, height: 24)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                        .animation(.easeInOut(duration: 0.2), value: isMenuOpen)
//                    }
//                    .onTapGesture { isMenuOpen.toggle() }
                }
            }
        }
    }
}

// MARK: Functions
func iconName(for mode: ScheduleMode) -> String {
    switch mode {
    case .day: return "DaySelected"
    case .week: return "WeekSelected"
    case .calendar: return "MonthSelected"
    }
}


