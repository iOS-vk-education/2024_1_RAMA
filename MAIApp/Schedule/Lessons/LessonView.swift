//
//  LessonView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 21.11.2024.
//

import SwiftUI

struct LessonView: View {
    let timeRange: String;
    let classroom: String;
    let lessonType: String;
    let lessonName: String;
    let teacher: String;
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                BadgeComponentView(content: timeRange)
                Spacer()
                BadgeComponentView(content: classroom)
                BadgeComponentView(content: lessonType)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(lessonName)
                    .font(.headline)
                Text(teacher)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(12)
    }
}

#Preview {
    LessonView(timeRange: "xx:xx – xx:xx", classroom: "XXXX", lessonType: "XX", lessonName: "Название дисциплины", teacher: "Фамилия Имя Отчество")
}
