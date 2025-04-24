//
//  HomeViewModel.swift
//  Cats
//
//  Created by Oleg Gibadulin on 22.04.2025.
//

//import Foundation
//import Combine
//
//@MainActor
//final class HomeViewModel: ObservableObject {
//    @Published private(set) var cats: [Group] = []
//    @Published private(set) var favoriteIDs: Set<String> = []
//
//    private let service: GroupServiceProtocol
//    private let favoritesManager: FavoritesManagerProtocol
//    private var cancellables = Set<AnyCancellable>()
////
//    init(service: CatServiceProtocol = CatService(),
//         favoritesManager: FavoritesManagerProtocol? = nil) {
//        self.service = service
//        self.favoritesManager = favoritesManager ?? FavoritesManager()
//
//        self.favoritesManager.favoriteIDsPublisher
//            .receive(on: DispatchQueue.main)
//            .assign(to: &$favoriteIDs)
//    }
//
//    func loadData() {
//        Task {
//            async let cats = service.fetchCats()
//            async let _ = favoritesManager.loadFavorites()
//            self.cats = await cats
//        }
//    }
//
//    func isFavorite(_ cat: Cat) -> Bool {
//        favoriteIDs.contains(cat.id)
//    }
//
//    func toggleFavorite(_ cat: Cat) {
//        Task { await favoritesManager.toggleFavorite(id: cat.id) }
//    }
//}
