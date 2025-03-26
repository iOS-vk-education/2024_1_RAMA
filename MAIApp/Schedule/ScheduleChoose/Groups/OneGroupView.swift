import SwiftUI

struct OneGroupView: View {
    let group: String
    var isSelected: Bool
    
    var body: some View {
        Text(group)
            .padding(8)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.customBlue : Color.gray, lineWidth: 1)
                    .opacity(isSelected ? 0.75 : 0.25)
            )
            .font(.subheadline)
    }
}
