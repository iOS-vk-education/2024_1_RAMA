//
//  GroupAndWeekView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI

struct GroupAndWeekView: View {
    @State var selectedGroup: Group?
    @State var selectedCourse: Course
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                NavigationLink(destination: ChooseGroupView(selectedGroup: $selectedGroup, selectedCourse: selectedCourse)) {
                    GroupView(group: selectedGroup?.name ?? "Не выбрана")  // Отображаем текущую группу
                    }
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.25)
                            .frame(width: 1)
                        NavigationLink(destination: ChooseWeekView()) {
                            WeekView(week: "28.10 – 03.11")
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

//#Preview {
//    GroupAndWeekView()
//}
