////
////  RegView.swift
////  MAIApp
////
////  Created by Михаил Рахимов on 11.01.2025.
////
//
import SwiftUI

struct RegView: View {
    @State private var isDarkMode = false
    @EnvironmentObject var profileVM: ProfileViewModel
//    private let apiService = APIService()
    
    @Binding var isRegistration: Bool
    @AppStorage("theme") var selectedTheme: Theme = .system
    @AppStorage("lang") var selectedLang: Lang = .ru
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        VStack {
            VStack (spacing: 30){
                Text("Регистрация")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.top, 100)
                
                VStack (spacing: 45){
                    TextField("Электронная почта", text: $profileVM.email)
                        .padding()
                        .foregroundColor(Color.gray)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                        .frame(width: 300, height: 20)
                    
                    
                    SecureField("Пароль", text: $profileVM.password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .frame(width: 300, height: 20)
                        .textContentType(.newPassword)
                
                }
                .padding(.top, 20)
                
                Button {
//                    profileVM.register()
                } label: {
                    Text(profileVM.isLoading ? "Загрузка..." : "Зарегистрироваться")
                        .bold()
                        .frame(width: 300, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.customBlue)
                        .cornerRadius(10)
                }
                .disabled(profileVM.isLoading)
            }
            .padding()
            VStack (spacing: 10){
                Button{
                    print("GitHub")
                } label: {
                    Text("Вход с помощью GitHub")
                        .padding()
                        .bold()
                        .frame(width: 300, height: 40)
                        .foregroundColor(Color.black)
                        .background(Color.customGray)
                        .cornerRadius(15)
                }
                
                Button{
                    print("VK")
                } label: {
                    Text("Вход с помощью VK")
                        .padding()
                        .bold()
                        .frame(width: 300, height: 40)
                        .foregroundColor(Color.black)
                        .background(Color.customGray)
                        .cornerRadius(15)
                }
                
                Button{
                    print("Google")
                } label: {
                    Text("Вход с помощью Google")
                        .padding()
                        .bold()
                        .frame(width: 300, height: 40)
                        .foregroundColor(Color.black)
                        .background(Color.customGray)
                        .cornerRadius(15)
                }
                
                Button{
                    isRegistration = false
                } label: {
                    Text("Авторизация")
                        .bold()
                        .frame(width: 300, height: 40)
                        .font(.system(size: 16, weight: .semibold))
                        .cornerRadius(10)
                        .foregroundColor(Color.customBlue)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(colorScheme == .light ? "MAI_LIGHT" : "MAI_DARK")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                        
                        Text("MAI Students")
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Picker("Lang", selection: $selectedLang) {
                        Image(systemName: "globe").tag(Lang.ru)
                            .foregroundColor(.white)
                    }.pickerStyle(MenuPickerStyle())
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                                Picker("Theme", selection: $selectedTheme) {
                                    Image(systemName: "circle.lefthalf.filled").tag(Theme.system)
                                    Image(systemName: "sun.max.fill").tag(Theme.light)
                                    Image(systemName: "moon.fill").tag(Theme.dark)
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                
            }
            .preferredColorScheme(colorScheme == .light ? .light : .dark)
            
        Spacer()
    
    
            }
    }
}

////#Preview {
////    RegView()
////}
