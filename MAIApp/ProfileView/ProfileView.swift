import SwiftUI

struct ProfileView: View {
//    @State var name: String = "Имя не указано"
//    @State var group: String = "Группа не указана"
    @StateObject var profileVM: ProfileViewModel
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
//    @StateObject private var profileData = ProfileData()
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20) {
                    VStack{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.customGray)
                        
                        Text(profileVM.name)
                            .font(.title2)
                        
                        Text(profileVM.group)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Настройки")
                            .font(.headline)
                        NavigationLink(destination: ChooseAppIconView()) {
                            ListItemView(title: "Изменить иконку приложения")
                        }
                        NavigationLink(destination: ChooseGroupView(groupSelectionViewModel: groupSelectionViewModel)) {
                            ListItemView(title: "Изменить группу")
                        }
                    }
                    
                }
                .padding()
                .navigationTitle("Профиль")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("получить группы")
                    }
                }
            }
        }
    }
}

//#Preview {
//    ProfileView(name: "Михаил Рахимов", group: "М8О-101БВ-24")
//}
