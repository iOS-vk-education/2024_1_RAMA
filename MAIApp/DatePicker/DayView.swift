//
//  DayView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

let days = ["пн", "вт", "ср", "чт", "пт", "сб"]

struct DayView: View {
    let day: Date
    let index: Int
    var isActive: Bool
    var namespace: Namespace.ID
    @Environment(\.colorScheme) var colorScheme
    
    var dayOfMonth: Int {
        return Calendar.current.component(.day, from: day)
    }
    
    var body: some View {
        ZStack{
            if isActive {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.activeBackground)
                    .shadow(
                            color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.1),
                            radius: 1, x: 0, y: 2
                            )
                    .matchedGeometryEffect(id: "activeDay", in: namespace)
            }
            
            VStack {
                Text(days[index])
                    .font(.caption)
                    .foregroundColor(isActive ? .primary : .secondary)
                Text(String(dayOfMonth))
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    @Previewable @Namespace var animationNamespace
    
    DayView(day: Date(), index: 0, isActive: true, namespace: animationNamespace)
}
