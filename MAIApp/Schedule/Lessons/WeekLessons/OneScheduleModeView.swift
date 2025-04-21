//
//  OneScheduleModeView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 05.04.2025.
//

import SwiftUI

struct OneScheduleModeView: View {
    let mode: String
    var isActive: Bool
    var namespace: Namespace.ID
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if isActive {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.activeBackground)
                    .shadow(
                        color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.1),
                        radius: 1, x: 0, y: 2
                    )
                    .matchedGeometryEffect(id: "activeMode", in: namespace)
            }
            
            HStack {
                Text(mode)
                    .font(.subheadline)
                    .foregroundStyle(isActive ? .primary : .secondary)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    @Previewable @Namespace var animationNamespace
    OneScheduleModeView(mode: "День", isActive: true, namespace: animationNamespace)
}
