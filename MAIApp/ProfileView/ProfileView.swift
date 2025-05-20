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
                        
                        if !profileVM.firstAndLastNames.isEmpty {
                            Text(profileVM.firstAndLastNames)
                                .font(.title2)
                        }
                        Text(profileVM.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Настройки")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            NavigationLink(destination: ChooseAppIconView()) {
                                SettingsButtonView(title: "Изменить иконку приложения", icon: "app.fill")
                            }
                            
                            NavigationLink(destination: ChooseGroupView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: weekViewModel)) {
                                SettingsButtonView(title: "Изменить группу", icon: "person.3.fill")
                            }
                            
                            Button(action: {
                                profileVM.logoutUser()
                            }) {
                                SettingsButtonView(title: "Выйти из аккаунта", icon: "rectangle.portrait.and.arrow.right", isDestructive: true)
                            }
                        }
                        .padding(.horizontal)
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

struct SettingsButtonView: View {
    let title: String
    let icon: String
    var isDestructive: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(isDestructive ? .red : .blue)
                .frame(width: 30)
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

//#Preview {
//    ProfileView(name: "Михаил Рахимов", group: "М8О-101БВ-24")
//}
