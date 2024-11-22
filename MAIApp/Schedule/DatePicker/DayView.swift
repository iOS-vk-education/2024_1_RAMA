//
//  DayView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

let days = ["пн", "вт", "ср", "чт", "пт", "сб"]
let date = ["28", "29", "30", "31", "01", "02"]

struct DayView: View {
    let day: Int
    let isActive: Bool
    var body: some View {
        VStack {
            Text(days[day])
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(date[day])
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(isActive ? .gray.opacity(0.1) : .clear)
    }
}


#Preview {
    DayView(day: 0, isActive: false)
}
