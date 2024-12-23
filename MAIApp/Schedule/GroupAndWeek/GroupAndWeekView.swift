//
//  GroupAndWeekView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI



struct GroupAndWeekView: View {
    @Binding var weekNumber: Int
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                NavigationLink(destination: ChooseGroupView()) {
                    GroupView(group: "М3О-212Б-23")
                }
                Rectangle()
                    .fill(.gray)
                    .opacity(0.25)
                    .frame(width: 1)
                NavigationLink(destination: ChooseWeekView(weekNumber: $weekNumber)) {
                    WeekView(weekNumber: $weekNumber)
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
}

#Preview {
    GroupAndWeekView(weekNumber: .constant(52))
}
