import Foundation
import Combine

class LessonViewModel: ObservableObject {
    @Published var groupSchedule: GroupSchedule?
    @Published var error: Error?
    @Published var isLoading = false

    private var dataTask: URLSessionDataTask?
    
    // MARK: - Public Methods
    func loadSchedule(for group: String) {
        guard !group.isEmpty else {
            DispatchQueue.main.async {
                self.error = NSError(domain: "Group not selected", code: 0, userInfo: nil)
            }
            return
        }

        dataTask?.cancel()

        let groupHash = group.md5Hash()
        let urlBase = "https://public.mai.ru/schedule/data/\(groupHash).json"
        let urlBackend = "https://mai-students.ru/api/v1/schedule/\(groupHash)"
        guard let url = URL(string: urlBase) else {
            DispatchQueue.main.async {
                self.error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            return
        }

        isLoading = true

        dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.error = error
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.error = NSError(domain: "No Data", code: 0, userInfo: nil)
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let schedule = try decoder.decode(GroupSchedule.self, from: data)
                
                DispatchQueue.main.async {
                    self.groupSchedule = schedule
                    self.error = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }

        dataTask?.resume()
    }
    
    // MARK: - Helpers
    func findLessonDay(for date: Date) -> DaySchedule? {
        guard let schedule = groupSchedule else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date)
        return schedule.schedule[dateString]
    }

    func cancelRequest() {
        dataTask?.cancel()
        isLoading = false
    }
}

extension LessonViewModel {
    func getSchedule(for date: Date) -> DaySchedule? {
        let dateString = DateFormatter.yyyyMMdd.string(from: date)
        // Обращаемся к свойству schedule в GroupSchedule
        return groupSchedule?.schedule[dateString]
    }
}



