//
//  DatePickerView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct DatePickerView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    @State private var selectedDay: Int = 0
    
    @Binding var weekNumber: Int
    var weekDates: [Date] {
        daysOfWeek(for: weekNumber)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6) { i in
                DayView(day: weekDates[i], index: i, isActive: selectedDay == i)
                    .onTapGesture {
                        selectedDay = i
                        print(selectedDay, weekDates[i + 1])
                    }
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
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    func daysOfWeek(for weekNumber: Int) -> [Date] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.firstWeekday = 2
        
        let currentYear = calendar.component(.year, from: Date())
        
        var components = DateComponents()
        components.year = currentYear
        components.weekOfYear = weekNumber
        components.weekday = calendar.firstWeekday
        
        guard let firstDayOfWeek = calendar.date(from: components) else {
            return []
        }
        
        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: firstDayOfWeek)
        }
    }
}

#Preview {
    DatePickerView(weekNumber: .constant(52))
}
