//
//  LessonsView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 21.11.2024.
//

import SwiftUI

struct LessonsView: View {
    let lessonDays: [LessonDay] = GetData()
    
    var body: some View {
        VStack {
            ForEach(lessonDays, id: \.day) { lessonDay in
                ForEach(Array(lessonDay.lessons.enumerated()), id: \.element.time_start) { index, lesson in
                    VStack {
                        LessonView(
                            timeRange: "\(lesson.time_start) – \(lesson.time_end)",
                            classroom: lesson.classroom,
                            lessonType: lesson.lessonType,
                            lessonName: lesson.lessonName,
                            teacher: lesson.teacher
                        )
                        if index < lessonDay.lessons.count - 1 {
                            Rectangle()
                                .fill(.gray)
                                .opacity(0.25)
                                .frame(height: 1)
                        }
                    }
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
