import Foundation
import Combine

enum loadingStates: String, CaseIterable {
    case loaded
    case loading
    case error
}

class LessonViewModel: ObservableObject {
    @Published private(set) var groupSchedule: GroupSchedule?
    @Published private(set) var error: Error?
    @Published private(set) var isLoading = false
    
    private var dataTask: URLSessionDataTask?
    private let scheduleManager: ScheduleManagerProtocol
    
    init(
        scheduleManager: ScheduleManagerProtocol = ScheduleManager()
    ) {
        self.scheduleManager = scheduleManager
    }
    
    
    func loadScheduleForGroup(for group: String) {
        Task { @MainActor in
            defer { isLoading = false }
            isLoading = true
            
            do {
                let schedule = try await scheduleManager.loadSchedule(for: group)
                self.groupSchedule = schedule
                
            } catch {
                self.error = error
            }
           }
    }

    // MARK: - Helpers
    func findLessonDay(for date: Date) -> DaySchedule? {
        guard let schedule = groupSchedule else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date)
        return schedule.schedule[dateString]
    }
    
    func getSchedule(for date: Date) -> DaySchedule? {
        let dateString = DateFormatter.yyyyMMdd.string(from: date)
        
        return groupSchedule?.schedule[dateString]
    }
}



