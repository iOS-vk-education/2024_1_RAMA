//
//  ScheduleModeView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 05.04.2025.
//


import SwiftUI

struct ScheduleModeView: View {
    @ObservedObject var viewModel: ScheduleModeViewModel
    @Namespace private var animationModeNamespace
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack(spacing: 0) {
            ForEach(viewModel.availableModes, id: \.self) { mode in
                Button(action: {
                    withAnimation(.spring(response: 0.3)) {
                        viewModel.selectMode(mode)
                    }
                } )
                
                {
                    OneScheduleModeView(mode: mode.rawValue,
                                        isActive: viewModel.selectedMode.rawValue == mode.rawValue,
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

#Preview {
    ScheduleModeView(viewModel: .init())
}
