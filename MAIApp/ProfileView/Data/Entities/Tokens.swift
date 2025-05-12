//
//  tokens.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 12.03.2025.
//

enum TokenConstants {
    static let ACCESS_TOKEN = "access_token"
    static let REFRESH_TOKEN = "refresh_token"
    static let USER = "user"
    static let SESSION_TOKEN = "session_token"
}

struct TokenInfo: Codable {
    let access_token: String
    let refresh_token: String
}


