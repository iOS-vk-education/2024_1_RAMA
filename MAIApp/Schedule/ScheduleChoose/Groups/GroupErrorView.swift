import SwiftUI

struct GroupErrorView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Групп для выбранного типа образования нет")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.top, 225)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
