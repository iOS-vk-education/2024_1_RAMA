import SwiftUI

struct ScheduleView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @ObservedObject var dateViewModel: DateViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject var lessonViewModel: LessonViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    @State private var isMenuOpen = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                if groupSelectionViewModel.selectedGroup == "" {
                    GroupAndWeekView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: dateViewModel)
                    ErrorGroupView()
                }
                else {
                    GroupAndWeekView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: dateViewModel)
                    WeekScheduleModeView(contentViewModel: contentViewModel)
                    
                    switch contentViewModel.selectedMode {
                    case .day:
                        DatePickerView(dateViewModel: dateViewModel)
                        LessonsView(
                            viewModel: lessonViewModel,
                            dateViewModel: dateViewModel,
                            groupSelectionViewModel: groupSelectionViewModel
                        )
                        .scheduleGesture(dateViewModel: dateViewModel, mode: .day)
                        
                    case .week:
                        WeekLessonsView(
                            viewModel: lessonViewModel,
                            dateViewModel: dateViewModel,
                            groupSelectionViewModel: groupSelectionViewModel
                        )
                        .scheduleGesture(dateViewModel: dateViewModel, mode: .week)
                    }
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
//    case .calendar: return "MonthSelected"
    }
}
