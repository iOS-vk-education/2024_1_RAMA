//
//  LessonsView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 21.11.2024.
//

import SwiftUI

struct LessonsView: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<4) { i in
                LessonView(timeRange: "xx:xx – xx:xx", classroom: "XXXX", lessonType: "XX", lessonName: "Название дисциплины", teacher: "Фамилия Имя Отчество")
                if i < 3 {
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.25)
                        .frame(height: 1)
                }
            }
        }
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.25)
                )
    }
}

#Preview {
    LessonsView()
}
