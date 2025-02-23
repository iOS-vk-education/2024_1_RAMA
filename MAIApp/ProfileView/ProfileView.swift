
import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20) {
                    VStack{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.customGray)
                        
                        Text("Михаил Рахимов")
                            .font(.title2)
                        
                        Text("М8О-101БВ-24")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Настройки")
                            .font(.headline)
                        NavigationLink(destination: ChooseAppIconView()) {
                            ListItemView(title: "Изменить иконку приложения")
                        }
                    }
                    
                }
                .padding()
                .navigationTitle("Профиль")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

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
    ProfileView()
}
