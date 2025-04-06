import SwiftUI

struct ErrorGroupView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("error_schedule")
                .padding(.top, 50)
            Text("Данные не указаны")
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .padding(.top, 15)
            Text("Укажите группу для отображения расписания.")
                .foregroundColor(.gray)
                .font(.system(size: 12, weight: .light, design: .rounded))
                .padding(.top, 1)
            Spacer()
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

