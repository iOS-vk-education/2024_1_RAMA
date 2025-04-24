//
//  CatRepository.swift
//  Cats
//
//  Created by Oleg Gibadulin on 22.04.2025.
//

import Foundation
import Combine


protocol FavoritesManagerProtocol: AnyObject {
    var favoriteIDsPublisher: Published<Set<String>>.Publisher { get }
    func loadFavorites() async
    func isFavorite(id: String) -> Bool
    func toggleFavorite(id: String) async
}


final class FavoritesManager: FavoritesManagerProtocol {
    @Published private(set) var favoriteIDs: Set<String> = []
    private let storage: FavoritesStorageProtocol
    private let service: GroupServiceProtocol

    var favoriteIDsPublisher: Published<Set<String>>.Publisher { $favoriteIDs }

    init(storage: FavoritesStorageProtocol = FavoritesStorage(),
         service: GroupServiceProtocol = GroupService()) {
        self.storage = storage
        self.service = service
    }

    func loadFavorites() async {
        favoriteIDs = await storage.getFavoriteIDs()
    }

    func isFavorite(id: String) -> Bool {
        favoriteIDs.contains(id)
    }

    func toggleFavorite(id: String) async {
        if favoriteIDs.contains(id) {
            await service.unlikeGroup(id: id)
            await storage.removeFavorite(id: id)
        } else {
            await service.likeGroup(id: id)
            await storage.saveFavorite(id: id)
        }
        favoriteIDs = await storage.getFavoriteIDs()
    }
}
