//
//  NetworkSchedule.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 02.02.2025.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        Array(Set(self))
    }
}

protocol ScheduleManagerDescription {
    func loadGroups() async throws -> [Group]
    func loadSchedule(for group: String) async throws -> GroupSchedule
}

enum ScheduleManagerError: Error {
    case invalidData
    case invalidUrl
}

final class ScheduleManager: ScheduleManagerDescription {
    
    static let shared: ScheduleManagerDescription = ScheduleManager()
    
    // MARK: - Data Loading
    func loadGroups() async throws -> [Group] {
        //            let urlBackend = "https://public.mai.ru/schedule/data/groups.json"
        let urlBase = "https://public.mai.ru/schedule/data/groups.json"
        
        guard let url = URL(string: urlBase) else {
            print("❌ [ERROR] Invalid URL")
            return []
        }
        
        do {
            print("⏳ [NETWORK] Starting data download...")
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // HTTP Status Check
            _ = response as? HTTPURLResponse
            
            
            // Raw Data Logging
            print("📥 [DATA] Received \(data.count) bytes")
            _ = String(data: data, encoding: .utf8)
            
            // Decoding
            print("🔨 [DECODE] Starting JSON decoding...")
            let decoder = JSONDecoder()
            let decodedGroups = try decoder.decode([Group].self, from: data)
            
            return decodedGroups
        }
        catch {
            print("❌ [ERROR] \(error)")
            return []
        }
    }
    
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Public Methods
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
