//
//  FavoritesStorage.swift
//  Cats
//
//  Created by Oleg Gibadulin on 22.04.2025.
//

import Foundation

protocol FavoritesStorageProtocol {
    func getFavoriteIDs() async -> Set<String>
    func saveFavorite(id: String) async
    func removeFavorite(id: String) async
}

actor FavoritesStorage: FavoritesStorageProtocol {
    private let key = "favoriteGroupIDs"
    private let defaults = UserDefaults.standard

    func getFavoriteIDs() async -> Set<String> {
        (defaults.array(forKey: key) as? [String]).map(Set.init) ?? []
    }

    func saveFavorite(id: String) async {
        var ids = await getFavoriteIDs()
        ids.insert(id)
        defaults.set(Array(ids), forKey: key)
    }

    func removeFavorite(id: String) async {
        var ids = await getFavoriteIDs()
        ids.remove(id)
        defaults.set(Array(ids), forKey: key)
    }
}
