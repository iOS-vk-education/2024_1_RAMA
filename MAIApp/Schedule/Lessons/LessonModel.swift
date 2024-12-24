//
//  LessonModel.swift
//  MAIApp
//
//  Created by Руслан on 23.12.2024.
//

import SwiftUI

struct Lesson {
    let time_start: String
    let time_end: String
    let lessonName: String
    let lessonType: String
    let teacher: String
    let classroom: String
}

struct LessonDay {
    let day: String
    let lessons: [Lesson]
    let count: Int
}

func GetData() -> [LessonDay] {
    [
        LessonDay(
            day: "21.11.24",
            lessons: [
                Lesson(time_start: "09:00", time_end: "10:30", lessonName: "Математический анализ", lessonType: "ПЗ", teacher: "Выск Наталия Дмитриевна", classroom: "3-321"),
                Lesson(time_start: "10:45", time_end: "12:15", lessonName: "Линейная алгебра и аналитическая геометрия", lessonType: "ЛК", teacher: "Васильев Михаил Иванович", classroom: "ГУК А-303"),
                Lesson(time_start: "13:00", time_end: "14:30", lessonName: "Основы теории электрических цепей", lessonType: "ПЗ", teacher: "Баев Андрей Борисович", classroom: "24Б-224")
            ],
            count: 3
        ),
//        LessonDay(
//            day: "22.11.24",
//            lessons: [
//                Lesson(time_start: "08:00", time_end: "09:30", lessonName: "Физика", lessonType: "ЛК", teacher: "Эйнштейн Альбертович", classroom: "Ф-101"),
//                Lesson(time_start: "09:45", time_end: "11:15", lessonName: "Программирование", lessonType: "ЛР", teacher: "Джавович Питонский", classroom: "И-302"),
//                Lesson(time_start: "11:30", time_end: "13:00", lessonName: "Философия", lessonType: "СМ", teacher: "Кант Иммануилович", classroom: "Философский зал")
//            ]
//        ),
//        LessonDay(
//            day: "23.11.24",
//            lessons: [
//                Lesson(time_start: "10:00", time_end: "11:30", lessonName: "История", lessonType: "ЛК", teacher: "Горбачев Михаил Сергеевич", classroom: "Исторический корпус, ауд. 5"),
//                Lesson(time_start: "12:00", time_end: "13:30", lessonName: "Химия", lessonType: "ЛР", teacher: "Менделеев Дмитрий Иванович", classroom: "Х-205"),
//                Lesson(time_start: "14:00", time_end: "15:30", lessonName: "Физкультура", lessonType: "ПЗ", teacher: "Шварценеггер Арнольдович", classroom: "Спортзал №1")
//            ]
//        )
    ]
}
