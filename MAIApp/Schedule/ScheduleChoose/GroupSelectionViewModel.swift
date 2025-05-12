import Foundation
import SwiftUI
import Combine

protocol GroupSelectionProtocol {
    func likeGroup(id: String) async
    func unlikeGroup(id: String) async
}

final class GroupSelectionViewModel: ObservableObject {
    @Published var allGroups: [Group] = []
    @Published var selectedFaculty: String = ""
    @Published var selectedCourse: String = ""
    @Published var selectedLevel: String = ""
    @Published var selectedGroup: String = ""
    @Published var isLoading = false
    @Published private(set) var favoriteIDs: Set<String> = []
    
    private let service: GroupServiceProtocol
    private let favoritesManager: FavoritesManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: GroupServiceProtocol = GroupService(),
         favoritesManager: FavoritesManagerProtocol? = nil) {
        self.service = service
        self.favoritesManager = favoritesManager ?? FavoritesManager()

        self.favoritesManager.favoriteIDsPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$favoriteIDs)
    }
    
    // MARK: Favourite Groups
    func isFavorite(_ group: String) -> Bool {
        favoriteIDs.contains(group)
    }

    func toggleFavorite(_ group: String) {
        Task { await favoritesManager.toggleFavorite(id: group) }
    }
    
    // MARK: Load data
    @MainActor
    func loadDecodedGroups() {
        Task(priority: .high) { @MainActor in
            defer {
                isLoading = false
            }
            
            isLoading = true
            self.allGroups = try await ScheduleManager.loadGroups()
            self.logAvailableData()
        }
    }
    // MARK: - Data Filtering
    var faculties: [String] {
        let faculties = Set(allGroups.map { $0.fac })
            .sorted { lhs, rhs in
                extractInstituteNumber(lhs) < extractInstituteNumber(rhs)
            }
            return faculties
        }
    
    var courses: [String] {
        let normalizedFaculty = selectedFaculty.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let filtered = allGroups
            .filter {
                $0.fac.trimmingCharacters(in: .whitespacesAndNewlines) == normalizedFaculty
            }
            .map { $0.course }
            .unique()
            .sorted()
        return filtered
    }
    
    var levels: [String] {
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
        return filtered
    }
    
    var groups: [Group] {
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
private func extractInstituteNumber(_ faculty: String) -> Int {
    let numbers = faculty.components(separatedBy: CharacterSet.decimalDigits.inverted)
    return Int(numbers.joined()) ?? Int.max
}

private func extractGroupNumber(_ group: Group) -> Int {
    let numbers = group.name.components(separatedBy: CharacterSet.decimalDigits.inverted)
    return Int(numbers.joined()) ?? Int.max
}
