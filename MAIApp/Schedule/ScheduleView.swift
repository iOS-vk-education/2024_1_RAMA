import SwiftUI

struct ScheduleView: View {
    @State var weekNumber = getWeekNumber()
    @State private var selectedDay: Date = Date()
    @State private var scheduleMode: ScheduleMode = .day
    @State private var isMenuOpen = false
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @ObservedObject var weekViewModel: WeekViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                if groupSelectionViewModel.selectedGroup == "" {
                    
                    GroupAndWeekView(weekNumber: $weekNumber, selectedDay: $selectedDay, groupSelectionViewModel: groupSelectionViewModel, weekViewModel: weekViewModel)


                    
                    ErrorGroupView()
                    
                }
                
                else if scheduleMode == .day {

                    GroupAndWeekView(weekNumber: $weekNumber, selectedDay: $selectedDay, groupSelectionViewModel: groupSelectionViewModel, weekViewModel: weekViewModel)

                    DatePickerView(selectedDay: $selectedDay, weekNumber: $weekNumber)
                    
                    LessonsView(
                        selectedDay: $selectedDay,
                        selectedGroup: $groupSelectionViewModel.selectedGroup,
                        viewModel: LessonViewModel()
                    )
                    
                    Spacer()
                    
                }
                
                
                else if scheduleMode == .week {
                    

                    GroupAndWeekView(weekNumber: $weekNumber, selectedDay: $selectedDay, groupSelectionViewModel: groupSelectionViewModel, weekViewModel: weekViewModel)
                    
                    LessonsView(
                        selectedDay: $selectedDay,
                        selectedGroup: $groupSelectionViewModel.selectedGroup,

                        viewModel: LessonViewModel()
                    )
                    
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Расписание")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Режим", selection: $scheduleMode) {
                            ForEach(ScheduleMode.allCases, id: \.self) { mode in
                                HStack(spacing: 12) {
                                    Image(iconName(for: mode))
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text(mode.rawValue)
                                }
                                .tag(mode)
                            }
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 40, height: 40)
                                .foregroundColor(isMenuOpen ? .blue : Color(.systemGray5))
                            
                            if isMenuOpen {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .bold))
                            } else {
                                Image(iconName(for: scheduleMode))
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary)
                            }
                        }
                        .animation(.easeInOut(duration: 0.2), value: isMenuOpen)
                    }
                    .onTapGesture { isMenuOpen.toggle() }
                }
            }
        }
    }
}

// MARK: Functions

func getWeekNumber(from date: Date = Date()) -> Int {
    let calendar = Calendar.current
    return calendar.component(.weekOfYear, from: date) - 1
}

func iconName(for mode: ScheduleMode) -> String {
    switch mode {
    case .day: return "DaySelected"
    case .week: return "WeekSelected"
    case .calendar: return "MonthSelected"
    }
}


