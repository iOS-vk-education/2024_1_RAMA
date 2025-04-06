import SwiftUI

struct LevelErrorView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Выберите тип образования")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.top, 225)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

