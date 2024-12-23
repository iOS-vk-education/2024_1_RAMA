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
    let day: Date
    let index: Int
    var isActive: Bool
    var dayOfMonth: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: day)
    }
    
    var body: some View {
        VStack {
            Text(days[index])
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(String(dayOfMonth))
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(isActive ? .gray.opacity(0.1) : .clear)
        .onAppear {
            print(day)
        }
    }
}


#Preview {
    DayView(day: Date(), index: 0, isActive: false)
}
