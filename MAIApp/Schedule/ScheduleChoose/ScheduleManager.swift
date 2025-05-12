import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        Array(Set(self))
    }
}

protocol ScheduleManagerProtocol {
    static func loadGroups() async throws -> [Group]
    func loadSchedule(for group: String) async throws -> GroupSchedule
}

enum ScheduleManagerError: Error {
    case invalidData
    case invalidUrl
}

final class ScheduleManager: ScheduleManagerProtocol {
    
    static func loadGroups() async throws -> [Group] {
        //            let urlBackend = "https://public.mai.ru/schedule/data/groups.json"
        let urlBase = "https://public.mai.ru/schedule/data/groups.json"
        
        guard let url = URL(string: urlBase) else {
            throw ScheduleManagerError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // HTTP Status Check
            _ = response as? HTTPURLResponse
            
//            print("📥 [DATA] Received \(data.count) bytes")
            _ = String(data: data, encoding: .utf8)
            
            let decoder = JSONDecoder()
            let decodedGroups = try decoder.decode([Group].self, from: data)
            
            return decodedGroups
        }
        catch {
            print("❌ [ERROR] \(error)")
            throw error
        }
    }
    
    func loadSchedule(for group: String) async throws -> GroupSchedule {
        guard !group.isEmpty else {
            throw ScheduleManagerError.invalidData
        }
        
        do {
            let groupHash = group.md5Hash()
            let urlBase = "https://public.mai.ru/schedule/data/\(groupHash).json"
            guard let url = URL(string: urlBase) else {
                throw ScheduleManagerError.invalidUrl
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(GroupSchedule.self, from: data)
        }
        catch {
            print("❌ [ERROR] \(error)")
            throw error
        }
    }
}
