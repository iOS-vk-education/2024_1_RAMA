import SwiftUI

struct ListItemView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.customGray))
        .cornerRadius(15)
    }
}

#Preview {
    ListItemView(title: "Тест")
}
