//
//  ScheduleModeView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 05.04.2025.
//

import SwiftUI

struct ScheduleModeView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    @Namespace private var animationModeNamespace
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack(spacing: 12) { 
            ForEach(contentViewModel.availableModes, id: \.self) { mode in
                Button(action: {
                    withAnimation(.spring(response: 0.3)) {
                        contentViewModel.selectMode(mode)
                    }
                }) {
                    OneScheduleModeView(mode: mode.rawValue,
                                        isActive: contentViewModel.selectedMode.rawValue == mode.rawValue,
                                        namespace: animationModeNamespace
                    )
                }
                .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(6)
        .fixedSize(horizontal: false, vertical: true)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
