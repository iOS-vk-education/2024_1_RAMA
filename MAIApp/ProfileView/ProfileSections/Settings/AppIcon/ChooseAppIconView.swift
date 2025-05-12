//
//  ProfileView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 07.02.2025.
//

import SwiftUI

struct ChooseAppIconView: View {
   @AppStorage("active_icon") var activeAppIcon: String = "AppIcon"
   
   let icons = [
       Icon(name: "AppIcon", image: "appicon"),
       Icon(name: "AppIcon 1", image: "appicon1"),
       Icon(name: "AppIcon 2", image: "appicon2"),
       Icon(name: "AppIcon 3", image: "appicon3"),
       Icon(name: "AppIcon 4", image: "appicon4")
   ]
   
   var body: some View {
       NavigationStack {
           ScrollView {
               LazyVGrid(columns: [
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())
               ], spacing: 20) {
                   ForEach(icons, id: \.name) { icon in
                       VStack {
                           Image(icon.image)
                               .resizable()
                               .frame(width: 60, height: 60)
                               .cornerRadius(12)
                               .overlay(
                                   RoundedRectangle(cornerRadius: 12)
                                       .stroke(activeAppIcon == icon.name ? Color.blue : Color.clear, lineWidth: 2)
                               )
                        
                       }
                       .onTapGesture {
                           withAnimation {
                               activeAppIcon = icon.name
                               let iconName = icon.name == "AppIcon" ? nil : icon.name
                               UIApplication.shared.setAlternateIconName(icon.name) { error in
                                   if let error = error {
                                        print("Ошибка при смене иконки: \(error.localizedDescription)")
                                    } else {
                                        print("Иконка изменена на \(iconName ?? "основную")")
                                    }
                               }
                           }
                       }
                   }
               }
               .padding()
           }
           .padding(.horizontal, 16)
           .padding(.vertical)
           .navigationTitle("Изменение иконки")
           .navigationBarTitleDisplayMode(.inline)
       }
   }
}

struct Icon {
   let name: String
   let image: String
}


