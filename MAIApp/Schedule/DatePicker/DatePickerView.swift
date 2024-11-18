//
//  DatePickerView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct DatePickerView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6) { i in
                DayView(day: i)
                    .frame(maxWidth: .infinity)
                if i < 5 {
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.25)
                        .frame(width: 1)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.25)
                )
    }
}

#Preview {
    DatePickerView()
}
