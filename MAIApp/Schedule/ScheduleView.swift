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
                        selectedGroup: $groupSelectionViewModel.selectedGroup
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
                    NavigationLink("Избранные", destination: FavoritesScreen(groupSelectionViewModel: groupSelectionViewModel))
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


