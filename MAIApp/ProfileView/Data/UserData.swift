import Foundation

struct User: Codable, Identifiable {
    var first_name: String?
    var last_name: String?
    var bio: String?
    var email: String
    enum AuthType: String, Codable {
        case `default`
        case yandex
        case google
        case github
    }
    var auth_type: AuthType
    var course: Int?
    var group_id: String
    var institute: String?
    var role: String
    var id: String = UUID().uuidString
    
    init(email: String, password: String = "", first_name: String? = nil, last_name: String? = nil) {
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.auth_type = .default
        self.group_id = ""
        self.role = "user"
    }
} 
