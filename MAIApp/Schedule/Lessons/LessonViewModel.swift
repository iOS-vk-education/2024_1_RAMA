import Foundation
import Combine

final class LessonViewModel: ObservableObject {
    @Published var groupSchedule: GroupSchedule?
    @Published var error: Error?
    @Published var isLoading = false

    private var dataTask: URLSessionDataTask?
    let scheduleManager = ScheduleManager()
    
    // MARK: - Public Methods
    func loadScheduleForGroup(for group: String) {
        Task(priority: .high) { @MainActor in
            defer {
                isLoading = false
            }
            
            isLoading = true
            let schedule = try await scheduleManager.loadSchedule(for: group)
            self.groupSchedule = schedule
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
}

extension LessonViewModel {
    func getSchedule(for date: Date) -> DaySchedule? {
        let dateString = DateFormatter.yyyyMMdd.string(from: date)
        
        return groupSchedule?.schedule[dateString]
    }
}



