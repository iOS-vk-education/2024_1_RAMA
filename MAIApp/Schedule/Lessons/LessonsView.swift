//
//  LessonsView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 21.11.2024.
//

import SwiftUI
//
//struct LessonsView: View {
//    let lessonDays: [LessonDay] = GetData()
//    
//    var body: some View {
//        VStack {
//            ForEach(lessonDays, id: \.day) {
//                lessonDay in ForEach(Array(lessonDay.lessons.enumerated()), id: \.element.time_start) {
//                    index, lesson in
//                    VStack {
//                        LessonView(
//                            timeRange: "\(lesson.time_start) – \(lesson.time_end)",
//                            classroom: lesson.classroom,
//                            lessonType: lesson.lessonType,
//                            lessonName: lesson.lessonName,
//                            teacher: lesson.teacher
//                        )
//                        if index < lessonDay.lessons.count - 1 {
//                            Rectangle()
//                                .fill(.gray)
//                                .opacity(0.25)
//                                .frame(height: 1)
//                        }
//                    }
//                }
//            }
//        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(.gray, lineWidth: 1)
//                .opacity(0.25)
//        )
//    }
//}

struct LessonsView: View {
    @Binding var selectedDay: Date
    @Binding var selectedGroup: String

    let scheduleModel: ScheduleModel

    var body: some View {
        ScrollView {
            VStack {
                if let selectedLessonDay = findLessonDay(for: selectedDay, group: selectedGroup) {
                    VStack {
                        ForEach(Array(selectedLessonDay.pairs.keys.sorted()), id: \.self) { timeStart in
                            if let pair = selectedLessonDay.pairs[timeStart] {
                                VStack {
                                    LessonView(
                                        timeRange: "\(formatTime(pair.timeStart)) – \(formatTime(pair.timeEnd))",
                                        classroom: pair.room,
                                        lessonType: pair.type,
                                        lessonName: pair.subject,
                                        lector: pair.lector
                                    )
                                    Rectangle()
                                        .fill(.gray)
                                        .opacity(0.25)
                                        .frame(height: 1)
                                }
                            }
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 1)
                            .opacity(0.25)
                    )
                } else {
                    VStack {
                        Spacer()
                        Image("error_schedule")
                            .padding(.top, 100)
                        Text("Данные не найдены :(")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .padding(.top, 15)
                        Text("Расписание ещё не выложили, либо в расписании ошибка.")
                            .foregroundColor(.gray)
                            .font(.system(size: 12, weight: .light, design: .rounded))
                            .padding(.top, 1)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
    
    func findLessonDay(for date: Date, group: String) -> DaySchedule? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date)
        
        print("Ищем расписание для группы: \(group), дата: \(dateString)")  // Выводим для отладки
        
        if let groupSchedule = scheduleModel.obtainGroupSchedule().first(where: { $0.group == selectedGroup }) {
            print("Найдено расписание для группы: \(groupSchedule.group)")  // Выводим для отладки
            
            // Ищем по дате
            if let selectedLessonDay = groupSchedule.schedule[dateString] {
                print("Найдено расписание для дня: \(dateString)")  // Выводим для отладки
                return selectedLessonDay
            } else {
                print("Не найдено расписание для дня: \(dateString)")  // Выводим для отладки
            }
        } else {
            print("Не найдено расписание для группы: \(group)")  // Выводим для отладки
        }
        return nil
    }
    
    func formatTime(_ timeString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        
        if let date = inputFormatter.date(from: timeString) {
            return outputFormatter.string(from: date)
        }
        return timeString
    }
}
//struct LessonsView: View {
//    let lessonDays: [LessonDay] = GetData()
//    @Binding var selectedDay: Date
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                if let selectedLessonDay = lessonDays.first(where: { Calendar.current.isDate($0.day, inSameDayAs: selectedDay) }) {
//                    VStack {
//                        ForEach(Array(selectedLessonDay.lessons.enumerated()), id: \.element.time_start) { index, lesson in
//                            VStack {
//                                LessonView(
//                                    timeRange: "\(lesson.time_start) – \(lesson.time_end)",
//                                    classroom: lesson.classroom,
//                                    lessonType: lesson.lessonType,
//                                    lessonName: lesson.lessonName,
//                                    lector: lesson.lector
//                                )
//                                if index < selectedLessonDay.lessons.count - 1 {
//                                    Rectangle()
//                                        .fill(.gray)
//                                        .opacity(0.25)
//                                        .frame(height: 1)
//                                }
//                            }
//                        }
//                    }
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(.gray, lineWidth: 1)
//                            .opacity(0.25)
//                    )
//                } else {
//                    VStack {
//                        Spacer()
//                        Image("error_schedule")
//                            .padding(.top, 100)
//                        Text("Данные не найдены :(")
//                            .font(.system(size: 20, weight: .medium, design: .rounded))
//                            .padding(.top, 15)
//                        Text("Расписание ещё не выложили, либо в расписании ошибка.")
//                            .foregroundColor(.gray)
//                            .font(.system(size: 12, weight: .light, design: .rounded))
//                            .padding(.top, 1)
//                        Spacer()
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                }
//            }
//        }
//    }
//}



//#Preview {
//    LessonsView(selectedDay: )
//}
