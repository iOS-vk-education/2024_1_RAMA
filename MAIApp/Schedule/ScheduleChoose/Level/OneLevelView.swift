import SwiftUI

struct OneLevelView: View {
    let level: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(level)
                .padding(8)
                .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.customBlue : Color.gray, lineWidth: 1)
                        .opacity(isSelected ? 0.75 : 0.25)
                )
                .font(.subheadline)
        }
    }
}

