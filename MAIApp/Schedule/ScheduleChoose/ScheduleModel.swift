//
//  ScheduleModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 02.02.2025.
//

import Foundation
import SwiftUI

struct Group: Decodable {
    let name: String
    let fac: String
    let level: String
    let course: String
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        Array(Set(self))
    }
}

class GroupSelectionModel: ObservableObject {
    @Published var allGroups: [Group] = []
    @Published var selectedFaculty: String = ""
    @Published var selectedCourse: String = ""
    @Published var selectedLevel: String = ""
    @Published var selectedGroup: String = ""
    @Published var facultyIsSelected: String = ""
    
    
    // MARK: - Data Loading
        @MainActor
        func loadGroups() async {
            guard let url = URL(string: "https://public.mai.ru/schedule/data/groups.json") else {
                print("❌ [ERROR] Invalid URL")
                return
            }
            
            do {
                print("⏳ [NETWORK] Starting data download...")
                let (data, response) = try await URLSession.shared.data(from: url)
                
                // HTTP Status Check
                _ = response as? HTTPURLResponse
//                if httpResponse = response as? HTTPURLResponse {
//                    print("🔍 [NETWORK] HTTP Status Code: \(httpResponse.statusCode)")
//                    guard 200..<300 ~= httpResponse.statusCode else {
//                        print("❌ [ERROR] Server returned status: \(httpResponse.statusCode)")
//                        return
//                    }
//                }
                
                // Raw Data Logging
                print("📥 [DATA] Received \(data.count) bytes")
                _ = String(data: data, encoding: .utf8)
//                if jsonString = String(data: data, encoding: .utf8) {
//                    print("📄 [JSON] Raw data preview:\n\(String(jsonString.prefix(500)))...")
//                }
                
                // Decoding
                print("🔨 [DECODE] Starting JSON decoding...")
                let decodedGroups = try JSONDecoder().decode([Group].self, from: data)
                
                DispatchQueue.main.async {
                    self.allGroups = decodedGroups
                    print("✅ [SUCCESS] Loaded \(decodedGroups.count) groups")
                    self.logAvailableData()
                }
                
            } catch let error as DecodingError {
                handleDecodingError(error)
            } catch {
                print("❌ [ERROR] Network request failed: \(error.localizedDescription)")
            }
        }
        
        // MARK: - Data Filtering
    var faculties: [String] {
        let faculties = Set(allGroups.map { $0.fac })
            .sorted { lhs, rhs in
                extractInstituteNumber(lhs) < extractInstituteNumber(rhs)
            }
        
//            print("\n=== FACULTIES ===")
//            print("Available: \(faculties.joined(separator: ", "))")
//            print("Selected: \(selectedFaculty)")
//            print("=================\n")
            return faculties
        }
        
        var courses: [String] {
            //Удаление "нежелательных" пробелов
            let normalizedFaculty = selectedFaculty.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let filtered = allGroups
                .filter {
                    $0.fac.trimmingCharacters(in: .whitespacesAndNewlines) == normalizedFaculty
                }
                .map { $0.course }
                .unique()
                .sorted()
            
//            print("\n=== COURSES ===")
//            print("Faculty: \(selectedFaculty)")
//            print("Available: \(filtered.joined(separator: ", "))")
//            print("Selected: \(selectedCourse)")
//            print("Total: \(filtered.count)")
//            print("===============\n")
            return filtered
        }
        
        var levels: [String] {
            //Удаление "нежелательных" пробелов
            let normalizedFaculty = selectedFaculty.trimmingCharacters(in: .whitespacesAndNewlines)
            let normalizedCourse = selectedCourse.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let filtered = allGroups
                .filter {
                    $0.fac.trimmingCharacters(in: .whitespacesAndNewlines) == normalizedFaculty &&
                    $0.course.trimmingCharacters(in: .whitespacesAndNewlines) == normalizedCourse
                }
                .map { $0.level }
                .unique()
                .sorted()
            
//            print("\n=== LEVELS ===")
//            print("Faculty: \(selectedFaculty)")
//            print("Course: \(selectedCourse)")
//            print("Available: \(filtered.joined(separator: ", "))")
//            print("Selected: \(selectedLevel)")
//            print("Total: \(filtered.count)")
//            print("==============\n")
            return filtered
        }
        
        var groups: [Group] {
            //Удаление "нежелательных" пробелов
            let normalizedFaculty = selectedFaculty.trimmingCharacters(in: .whitespacesAndNewlines)
            let normalizedCourse = selectedCourse.trimmingCharacters(in: .whitespacesAndNewlines)
            let normalizedLevel = selectedLevel.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let filtered = allGroups
                .filter {
                    $0.fac.trimmingCharacters(in: .whitespacesAndNewlines) == normalizedFaculty &&
                    $0.course.trimmingCharacters(in: .whitespacesAndNewlines) == normalizedCourse &&
                    $0.level.trimmingCharacters(in: .whitespacesAndNewlines) == normalizedLevel
                }
                .sorted { lhs, rhs in
                    extractGroupNumber(lhs) < extractGroupNumber(rhs)
                }
     
//            print("\n=== GROUPS ===")
//            print("Faculty: \(selectedFaculty)")
//            print("Course: \(selectedCourse)")
//            print("Level: \(selectedLevel)")
//            print("Available: \(allGroups.map { $0.name }.joined(separator: ", "))")
//            print("Selected: \(selectedGroup)")
//            print("Total: \(filtered.count)")
//            print("==============\n")
            return filtered
        }
    
        
        // MARK: - Debug Helpers
        private func logAvailableData() {
            print("\n📊 [DATA SUMMARY]")
            print("Total Groups: \(allGroups.count)")
            print("Unique Faculties: \(faculties.count)")
            print("First 3 Groups:")
            print("====================\n")
        }
        
        private func handleDecodingError(_ error: DecodingError) {
            print("\n❌ [DECODE ERROR]")
            switch error {
            case .keyNotFound(let key, let context):
                print("Missing key: \(key.stringValue)")
                print("Context: \(context.debugDescription)")
            case .typeMismatch(let type, let context):
                print("Type mismatch: \(type)")
                print("Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))")
            case .valueNotFound(let type, let context):
                print("Missing value: \(type)")
                print("Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))")
            case .dataCorrupted(let context):
                print("Corrupted data: \(context.debugDescription)")
                if let underlyingError = context.underlyingError {
                    print("Underlying error: \(underlyingError)")
                }
            @unknown default:
                print("Unknown decoding error")
            }
            print("====================\n")
        }
    }


// MARK: Functions
//для сортировки институтов
private func extractInstituteNumber(_ faculty: String) -> Int {
    let numbers = faculty.components(separatedBy: CharacterSet.decimalDigits.inverted)
    return Int(numbers.joined()) ?? Int.max
}

private func extractGroupNumber(_ group: Group) -> Int {
    let numbers = group.name.components(separatedBy: CharacterSet.decimalDigits.inverted)
    return Int(numbers.joined()) ?? Int.max
}
