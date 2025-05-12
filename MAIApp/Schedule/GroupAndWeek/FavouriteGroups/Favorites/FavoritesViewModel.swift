import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var allGroups: [Group] = []
    @Published private(set) var favoriteGroups: [Group] = []
    @Published private(set) var favoriteIDs: Set<String> = []

    private let favoritesManager: FavoritesManagerProtocol
    private var cancellables = Set<AnyCancellable>()

    init(
         favoritesManager: FavoritesManagerProtocol? = nil) {
        self.favoritesManager = favoritesManager ?? FavoritesManager()

        self.favoritesManager.favoriteIDsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ids in
                self?.favoriteIDs = ids
                self?.updateFavorites()
            }
            .store(in: &cancellables)
    }

    func loadData() {
        Task {
            async let groups = ScheduleManager.loadGroups()
            async let _ = favoritesManager.loadFavorites()
            allGroups = try await groups
            updateFavorites()
        }
    }

    private func updateFavorites() {
        favoriteGroups = allGroups.filter { favoriteIDs.contains($0.name) }
    }

    func toggleFavorite(_ group: Group) {
        Task { await favoritesManager.toggleFavorite(id: group.name) }
    }
}
