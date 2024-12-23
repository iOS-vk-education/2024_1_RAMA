//
//  LessonsView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 21.11.2024.
//

import SwiftUI

// Модель для расписания
struct ScheduleData: Decodable {
    let group: String
    let schedules: [String: DaySchedule] // Данные для каждого дня
}

// Модель для данных конкретного дня
struct DaySchedule: Decodable {
    let day: String
    let pairs: [String: [String: Lesson]] // Пары, отсортированные по времени
}

// Модель для урока
struct Lesson: Decodable {
    let time_start: String
    let time_end: String
    let lector: [String: String]
    let type: [String: Int]
    let room: [String: String]
    let lms: String
    let teams: String
    let other: String
    
    var lessonName: String { type.keys.first ?? "" }
    var lessonType: String { type.keys.first ?? "" }
    var teacher: String { lector.values.first ?? "Не указан" }
    var classroom: String { room.values.first ?? "Ауд." }
    var timeRange: String { "\(time_start) – \(time_end)" }
}

// Загружаем расписание из файла JSON
func loadScheduleData() -> ScheduleData? {
    guard let url = Bundle.main.url(forResource: "schedule", withExtension: "json") else {
        print("Файл schedule.json не найден в Bundle")
        return nil
    }
    do {
        let data = try Data(contentsOf: url)
        
        // Декодирование JSON в структуру ScheduleData
        let decodedData = try JSONDecoder().decode(ScheduleData.self, from: data)
        
        // Выводим декодированные данные для отладки
        print(decodedData)
        return decodedData
    } catch {
        print("Ошибка декодирования JSON: \(error.localizedDescription)")
        return nil
    }
}


struct LessonsView: View {
    let schedule: DaySchedule
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(schedule.pairs.keys.sorted(), id: \.self) { time in
                if let lessons = schedule.pairs[time] {
                    ForEach(lessons.keys.sorted(), id: \.self) { lessonName in
                        if let lesson = lessons[lessonName] {
                            LessonView(
                                timeRange: "\(lesson.time_start) – \(lesson.time_end)",
                                classroom: lesson.room.values.first ?? "Не указано",
                                lessonType: lesson.type.keys.first ?? "Не указано",
                                lessonName: lessonName,
                                teacher: lesson.lector.values.first ?? "Преподаватель"
                            )
                        }
                    }
                }
                Rectangle()
                    .fill(.gray)
                    .opacity(0.25)
                    .frame(height: 1)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
                .opacity(0.25)
        )
    }
}

    struct LessonsView_Previews: PreviewProvider {
        static var previews: some View {
            if let scheduleData = loadScheduleData(), let scheduleForDay28 = scheduleData.schedules["28.10.2024"] {
                return AnyView(LessonsView(schedule: scheduleForDay28))
            } else {
                return AnyView(Text("Ошибка: данные для дня не найдены"))
            }
        }
}

//struct LessonsView: View {
//    var body: some View {
//        VStack(spacing: 0) {
//            ForEach(0..<4) { i in
//                LessonView(timeRange: "xx:xx – xx:xx", classroom: "XXXX", lessonType: "XX", lessonName: "Название дисциплины", teacher: "Фамилия Имя Отчество")
//                if i < 3 {
//                    Rectangle()
//                        .fill(.gray)
//                        .opacity(0.25)
//                        .frame(height: 1)
//                }
//            }
//        }
//        .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(.gray, lineWidth: 1)
//                    .opacity(0.25)
//                )
//    }
//}

//#Preview {
//    LessonsView(schedule: )
//}
