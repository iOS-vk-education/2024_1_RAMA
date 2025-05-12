import SwiftUI

struct OneMenuItemView: View {
    
    var body: some View {
        VStack {
            Text("Изменение иконки")
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(
                    .gray
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .opacity(0.25)
                )
                .font(.subheadline)
        }
    }
}

#Preview {
    OneMenuItemView()
}
