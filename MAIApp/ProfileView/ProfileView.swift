import SwiftUI

struct ProfileView: View {
    @StateObject var profileVM: ProfileViewModel
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @ObservedObject var weekViewModel: DateViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20) {
                    VStack{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.customGray)
                        
                        Text(profileVM.email)
                            .font(.title2)
                        
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Настройки")
                            .font(.headline)
                        NavigationLink(destination: ChooseAppIconView()) {
                            ListItemView(title: "Изменить иконку приложения")
                        }
                        NavigationLink(destination: ChooseGroupView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: weekViewModel)) {
                            ListItemView(title: "Изменить группу")
                        }
                        Button(action: {
                            profileVM.logoutUser()
                            // После этого profileVM.isLoggedIn сfalse,
                            // и ContentView автоматически переклюна AuthContainerView
                        }) {
                            ListItemView(title: "Выйти из аккаунта")
                                .foregroundColor(.red)
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
                        Image(systemName: "bell")
                    }
                }
            }
        }
    }
}

//#Preview {
//    ProfileView(name: "Михаил Рахимов", group: "М8О-101БВ-24")
//}
