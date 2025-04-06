import SwiftUI

struct FacultyErrorView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("error_schedule")
                .padding(.top, 50)
            Spacer()
            Text("Не указаны все данные")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.top, 15)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

