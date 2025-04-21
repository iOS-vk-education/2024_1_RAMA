import SwiftUI

struct ContentView: View {
    @StateObject private var groupSelectionViewModel = GroupSelectionViewModel()
    @StateObject private var weekViewModel = WeekViewModel(scheduleManager: ScheduleManager())
    @StateObject private var profileVM = ProfileViewModel()
    @StateObject private var scheduleModeViewModel = ScheduleModeViewModel()
    @StateObject private var lessonViewModel = LessonViewModel()
    
    
    @State private var showAuth = true
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("theme") var selectedTheme: Theme = .system
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
            MapView()
                .tabItem {
                    Label("Карта", systemImage: "map.circle.fill")
                }
            ScheduleView(groupSelectionViewModel: groupSelectionViewModel, weekViewModel: weekViewModel, scheduleModeViewModel: scheduleModeViewModel, lessonViewModel: lessonViewModel)
                .environmentObject(groupSelectionViewModel)
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }
            DeadlinesView()
                .tabItem {
                    Label("Дедлайны", systemImage: "flame")
                }
            ProfileAuthView()
                .environmentObject(profileVM)
                .tabItem {
                    Label("Профиль", systemImage: "person.circle.fill")
                }
//            ProfileView(profileVM: profileVM, groupSelectionViewModel: groupSelectionViewModel)
//                .environmentObject(profileVM)
//                .tabItem {
//                    Label("Профиль", systemImage: "person.circle.fill")
//                }
            
        }
        .preferredColorScheme(selectedTheme.colorScheme)
    }
}
