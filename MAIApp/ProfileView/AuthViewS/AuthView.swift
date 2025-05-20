// //
// //  AuthView.swift
// //  MAIApp
// //
// //  Created by Михаил Рахимов on 11.01.2025.
// //

 import SwiftUI

 struct AuthView: View {
 //    @State private var email: String = ""
 //    @State private var password: String = ""
     @Binding var isRegistration: Bool
    
     @EnvironmentObject var profileVM: ProfileViewModel
     @AppStorage("theme") var selectedTheme: Theme = .system
     @AppStorage("lang") var selectedLang: Lang = .ru
     @Environment(\.colorScheme) var colorScheme
    
     var body: some View {
         VStack {
             VStack (spacing: 30){
                 Text("Авторизация")
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
                    
                 }
                 .padding(.top, 20)
                
                 Button{
                     
                     profileVM.loginUser()
                     
                 } label: {
                     Text("Войти")
                         .bold()
                         .frame(width: 300, height: 40)
                         .foregroundColor(Color.white)
                         .background(Color.customBlue)
                         .cornerRadius(15)
                 }
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
                     isRegistration = true
                 } label: {
                     Text("Регистрация")
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
 //                    .preferredColorScheme(colorScheme == .light ? .light : .dark)
                    
                 Spacer()
            
            
         }
     }
 }



// //
// ////#Preview {
// ////    AuthView()
// ////}
