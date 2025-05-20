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
        HStack(spacing: 8) {
            Text(group)
                .font(.subheadline)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            Spacer()
            
            Button(action: { vm.toggleFavorite(group) }) {
                Image(systemName: vm.isFavorite(group) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.system(size: 16))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.customBlue : Color.gray, lineWidth: 1)
                .opacity(isSelected ? 0.75 : 0.25)
        )
    }
}
