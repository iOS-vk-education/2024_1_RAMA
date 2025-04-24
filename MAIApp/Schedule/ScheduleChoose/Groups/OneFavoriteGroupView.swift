//
//  OneFavoriteGroupView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 24.04.2025.
//

import SwiftUI

struct OneFavoriteGroupView: View {
    @ObservedObject var vm: GroupSelectionViewModel
    let group: String
    var isSelected: Bool
//    let isFavorite: Bool
//    let onToggle: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            Text(group)
                .padding(8)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.customBlue : Color.gray, lineWidth: 1)
                        .opacity(isSelected ? 0.75 : 0.25)
                )
                .font(.subheadline)
            
            Button(action: { vm.toggleFavorite(group) }) {
                Image(systemName: vm.isFavorite(group) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .padding(8)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
            }
            .padding(10)
        }
    }
}
