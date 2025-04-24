import SwiftUI

struct ContentView: View {
    @StateObject private var groupSelectionViewModel = GroupSelectionViewModel()
    @StateObject private var weekViewModel = DateViewModel(scheduleManager: ScheduleManager())
    @StateObject private var profileVM = ProfileViewModel()
    @StateObject private var contentViewModel = ContentViewModel()
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
            ScheduleView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: weekViewModel, contentViewModel: contentViewModel, lessonViewModel: lessonViewModel)
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }
            DeadlinesView()
                .tabItem {
                    Label("Дедлайны", systemImage: "flame")
                }
            ProfileAuthView(profileVM: profileVM)
                .tabItem {
                    Label("Профиль", systemImage: "person.circle.fill")
                }
//            ProfileView(profileVM: profileVM, groupSelectionViewModel: groupSelectionViewModel, weekViewModel: weekViewModel)
//                .environmentObject(profileVM)
//                .tabItem {
//                    Label("Профиль", systemImage: "person.circle.fill")
//                }
            
        }
        .preferredColorScheme(selectedTheme.colorScheme)
    }
}
