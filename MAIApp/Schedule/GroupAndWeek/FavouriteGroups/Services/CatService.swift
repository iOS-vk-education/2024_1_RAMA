//
//  CatService.swift
//  Cats
//
//  Created by Oleg Gibadulin on 22.04.2025.
//

import Foundation

protocol GroupServiceProtocol {
    func likeGroup(id: String) async
    func unlikeGroup(id: String) async
}

final class GroupService: GroupServiceProtocol {

    func likeGroup(id: String) async {
        try? await Task.sleep(nanoseconds: 200_000_000)
        print("[Network] Liked group with id \(id)")
    }

    func unlikeGroup(id: String) async {
        try? await Task.sleep(nanoseconds: 200_000_000)
        print("[Network] Unliked group with id \(id)")
    }
}
