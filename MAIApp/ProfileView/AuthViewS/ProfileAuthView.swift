import SwiftUI

struct ProfileAuthView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isRegistration = false
    
    var body: some View {
        NavigationStack {
            if isRegistration {
                RegView(isRegistration: $isRegistration)
            } else {
                AuthView(isRegistration: $isRegistration)
            }
        }
    }
}

enum Theme: String {
    case light
    case dark
}

enum Lang: String {
    case ru
    case en
    case ch
}


