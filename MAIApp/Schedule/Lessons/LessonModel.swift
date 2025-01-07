//
//  LessonModel.swift
//  MAIApp
//
//  Created by Руслан on 23.12.2024.
//
//
//import SwiftUI
//import Foundation

//struct Lesson {
//    let time_start: String
//    let time_end: String
//    let lessonName: String
//    let lessonType: String
//    let lector: String
//    let classroom: String
//}
//
//struct LessonDay {
//    let day: Date
//    let lessons: [Lesson]
//    let count: Int
//}
//
//func GetData() -> [LessonDay] {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd.MM.yyyy"
//    return [
//        LessonDay(
//            day: dateFormatter.date(from: "06.01.2025")!,
//            lessons: [
//                Lesson(time_start: "09:00", time_end: "10:30", lessonName: "Математический анализ", lessonType: "ПЗ", lector: "Выск Наталия Дмитриевна", classroom: "3-321"),
//                Lesson(time_start: "10:45", time_end: "12:15", lessonName: "Линейная алгебра и аналитическая геометрия", lessonType: "ЛК", lector: "Васильев Михаил Иванович", classroom: "ГУК А-303"),
//                Lesson(time_start: "13:00", time_end: "14:30", lessonName: "Основы теории электрических цепей", lessonType: "ПЗ", lector: "Баев Андрей Борисович", classroom: "24Б-224")
//            ],
//            count: 3
//        ),
//        LessonDay(
//            day: dateFormatter.date(from: "07.01.2025")!,
//            lessons: [
//                Lesson(time_start: "08:00", time_end: "09:30", lessonName: "Физика", lessonType: "ЛК", lector: "Эйнштейн Альбертович", classroom: "Ф-101"),
//                Lesson(time_start: "09:45", time_end: "11:15", lessonName: "Программирование", lessonType: "ЛР", lector: "Джавович Питонский", classroom: "И-302"),
//                Lesson(time_start: "11:30", time_end: "13:00", lessonName: "Философия", lessonType: "СМ", lector: "Кант Иммануилович", classroom: "Философский зал")
//            ],
//            count: 3
//        ),
//        LessonDay(
//            day: dateFormatter.date(from: "08.01.2025")!,
//            lessons: [
//                Lesson(time_start: "10:00", time_end: "11:30", lessonName: "История", lessonType: "ЛК", lector: "Горбачев Михаил Сергеевич", classroom: "Исторический корпус, ауд. 5"),
//                Lesson(time_start: "12:00", time_end: "13:30", lessonName: "Химия", lessonType: "ЛР", lector: "Менделеев Дмитрий Иванович", classroom: "Х-205"),
//                Lesson(time_start: "14:00", time_end: "15:30", lessonName: "Физкультура", lessonType: "ПЗ", lector: "Шварценеггер Арнольдович", classroom: "Спортзал №1")
//            ],
//            count: 3
//        ),
//        LessonDay(
//            day: dateFormatter.date(from: "09.01.2025")!,
//            lessons: [
//                Lesson(time_start: "09:00", time_end: "10:30", lessonName: "Основы Российской Государственности", lessonType: "ЛК", lector: "Шевцов Александр Викторович", classroom: "ГУК А-208"),
//                Lesson(time_start: "10:45", time_end: "12:15", lessonName: "Линейная алгебра и аналитическая геометрия", lessonType: "ЛР", lector: "Бортаковский Александр Сергеевич", classroom: "ГУК В-214"),
//                Lesson(time_start: "13:30", time_end: "14:30", lessonName: "Дискретная математика", lessonType: "ЛК", lector: "Нефедов Виктор Николаевич", classroom: "ГУК В-214"),
//                Lesson(time_start: "14:45", time_end: "16:15", lessonName: "Введение в авиационную и ракетно-косимческую технику", lessonType: "ЛК", lector: "Кондаратцев Вадим Леонидович", classroom: "ГУК А-221"),
//                Lesson(time_start: "09:00", time_end: "10:30", lessonName: "Основы Российской Государственности", lessonType: "ЛК", lector: "Шевцов Александр Викторович", classroom: "ГУК А-208"),
//                Lesson(time_start: "10:45", time_end: "12:15", lessonName: "Линейная алгебра и аналитическая геометрия", lessonType: "ЛР", lector: "Бортаковский Александр Сергеевич", classroom: "ГУК В-214"),
//                Lesson(time_start: "13:30", time_end: "14:30", lessonName: "Дискретная математика", lessonType: "ЛК", lector: "Нефедов Виктор Николаевич", classroom: "ГУК В-214"),
//                Lesson(time_start: "14:45", time_end: "16:15", lessonName: "Введение в авиационную и ракетно-косимческую технику", lessonType: "ЛК", lector: "Кондаратцев Вадим Леонидович", classroom: "ГУК А-221")
//            ],
//            count: 8
//        ),
//        LessonDay(
//            day: dateFormatter.date(from: "10.01.2025")!,
//            lessons: [
//                Lesson(time_start: "08:00", time_end: "09:30", lessonName: "Физика", lessonType: "ЛК", lector: "Эйнштейн Альбертович", classroom: "Ф-101"),
//                Lesson(time_start: "09:45", time_end: "11:15", lessonName: "Программирование", lessonType: "ЛР", lector: "Джавович Питонский", classroom: "И-302"),
//                Lesson(time_start: "11:30", time_end: "13:00", lessonName: "Философия", lessonType: "СМ", lector: "Кант Иммануилович", classroom: "Философский зал")
//            ],
//            count: 3
//        ),
//        LessonDay(
//            day: dateFormatter.date(from: "11.01.2025")!,
//            lessons: [
//                Lesson(time_start: "08:00", time_end: "09:30", lessonName: "Физика", lessonType: "ЛК", lector: "Эйнштейн Альбертович", classroom: "Ф-101"),
//                Lesson(time_start: "09:45", time_end: "11:15", lessonName: "Математический Анализ", lessonType: "ЛК", lector: "Битюков", classroom: "И-302"),
//                Lesson(time_start: "11:30", time_end: "13:00", lessonName: "Философия", lessonType: "СМ", lector: "Кант Иммануилович", classroom: "Философский зал")
//            ],
//            count: 3
//        ),
//    ]
//}

import SwiftUI
import Foundation

struct Pair {
    let subject: String
    let timeStart: String
    let timeEnd: String
    let lector: String
    let type: String
    let room: String
    let lms: String
    let teams: String
    let other: String
}

struct DaySchedule {
    let day: String
    let pairs: [String: Pair]
}

struct GroupSchedule {
    let group: String
    var schedule: [String: DaySchedule]   
}

final class ScheduleModel {
    func obtainGroupSchedule() -> [GroupSchedule] {
        return [
            GroupSchedule(
                group: "M3О-212Б-23",
                schedule: [
                    "06.01.2025": DaySchedule(
                        day: "Пн",
                        pairs: [
                            "10:45:00": Pair(
                                subject: "Основы психологии",
                                timeStart: "10:45:00",
                                timeEnd: "12:15:00",
                                lector: "Ширяева Виктория Валерьевна",
                                type: "ЛК",
                                room: "3-435",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "07.01.2025": DaySchedule(
                        day: "Вт",
                        pairs: [
                            "9:00:00": Pair(
                                subject: "Программирование на языках высокого уровня",
                                timeStart: "9:00:00",
                                timeEnd: "10:30:00",
                                lector: "Максимов Алексей Николаевич",
                                type: "ЛК",
                                room: "3-429",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "10:45:00": Pair(
                                subject: "Общая физика",
                                timeStart: "10:45:00",
                                timeEnd: "12:15:00",
                                lector: "Преподаватель не указан",
                                type: "ЛК",
                                room: "ГУК В-228",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "13:00:00": Pair(
                                subject: "Физическая культура",
                                timeStart: "13:00:00",
                                timeEnd: "14:30:00",
                                lector: "Преподаватель не указан",
                                type: "ПЗ",
                                room: "--каф. 919",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "16:30:00": Pair(
                                subject: "Иностранный язык",
                                timeStart: "16:30:00",
                                timeEnd: "18:00:00",
                                lector: "Преподаватель не указан",
                                type: "ПЗ",
                                room: "3-346",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "08.01.2025": DaySchedule(
                        day: "Ср",
                        pairs: [
                            "9:00:00": Pair(
                                subject: "Программирование на языках высокого уровня",
                                timeStart: "9:00:00",
                                timeEnd: "10:30:00",
                                lector: "Максимов Алексей Николаевич",
                                type: "ЛК",
                                room: "3-429",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "10:45:00": Pair(
                                subject: "Общая физика",
                                timeStart: "10:45:00",
                                timeEnd: "12:15:00",
                                lector: "Преподаватель не указан",
                                type: "ЛК",
                                room: "ГУК В-228",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "13:00:00": Pair(
                                subject: "Физическая культура",
                                timeStart: "13:00:00",
                                timeEnd: "14:30:00",
                                lector: "Преподаватель не указан",
                                type: "ПЗ",
                                room: "--каф. 919",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "16:30:00": Pair(
                                subject: "Иностранный язык",
                                timeStart: "16:30:00",
                                timeEnd: "18:00:00",
                                lector: "Преподаватель не указан",
                                type: "ПЗ",
                                room: "3-346",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "09.01.2025": DaySchedule(
                        day: "Чт",
                        pairs: [
                            "9:00:00": Pair(
                                subject: "Основы психологии",
                                timeStart: "9:00:00",
                                timeEnd: "10:30:00",
                                lector: "Ширяева Виктория Валерьевна",
                                type: "ЛК",
                                room: "3-435",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "10.01.2025": DaySchedule(
                        day: "Пт",
                        pairs: [
                            "9:00:00": Pair(
                                subject: "Программирование на языках высокого уровня",
                                timeStart: "9:00:00",
                                timeEnd: "10:30:00",
                                lector: "Максимов Алексей Николаевич",
                                type: "ЛК",
                                room: "3-429",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "11.01.2025": DaySchedule(
                        day: "Cб",
                        pairs: [
                            "9:00:00": Pair(
                                subject: "Программирование на языках высокого уровня",
                                timeStart: "9:00:00",
                                timeEnd: "10:30:00",
                                lector: "Максимов Алексей Николаевич",
                                type: "ЛК",
                                room: "3-429",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "10:45:00": Pair(
                                subject: "Основы психологии",
                                timeStart: "10:45:00",
                                timeEnd: "12:15:00",
                                lector: "Ширяева Виктория Валерьевна",
                                type: "ЛК",
                                room: "3-435",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    )
                ]
            ),
            GroupSchedule(
                group: "М8О-101БВ-24",
                schedule: [
                    "06.01.2025": DaySchedule(
                        day: "Пн",
                        pairs: [
                            "13:00:00": Pair(
                                subject: "Программирование на языке Python",
                                timeStart: "13:00:00",
                                timeEnd: "14:30:00",
                                lector: "Крылов Сергей Сергеевич",
                                type: "ЛР",
                                room: "ГУК А-612",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "14:45:00": Pair(
                                subject: "Программирование на языке Python",
                                timeStart: "14:45:00",
                                timeEnd: "16:15:00",
                                lector: "Крылов Сергей Сергеевич",
                                type: "ЛР",
                                room: "ГУК А-612",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "07.01.2025": DaySchedule(
                        day: "Вт",
                        pairs: [
                            "13:00:00": Pair(
                                subject: "Математический анализ",
                                timeStart: "13:00:00",
                                timeEnd: "14:30:00",
                                lector: "Битюков Юрий Иванович",
                                type: "ЛК",
                                room: "ГУК Б-460",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "14:45:00": Pair(
                                subject: "Математический анализ",
                                timeStart: "14:45:00",
                                timeEnd: "16:15:00",
                                lector: "Битюков Юрий Иванович",
                                type: "ЛК",
                                room: "ГУК Б-460",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "08.01.2025": DaySchedule(
                        day: "Ср",
                        pairs: [
                            "10:45:00": Pair(
                                subject: "Физическая культура",
                                timeStart: "10:45:00",
                                timeEnd: "12:15:00",
                                lector: "Преподаватель не указан",
                                type: "ПЗ",
                                room: "--каф. 919",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "13:00:00": Pair(
                                subject: "Архитектура компьютера и информационных систем",
                                timeStart: "13:00:00",
                                timeEnd: "14:30:00",
                                lector: "Зайцев Валентин Евгеньевич",
                                type: "ЛК",
                                room: "ГУК В-221",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "09.01.2025": DaySchedule(
                        day: "Чт",
                        pairs: [
                            "09:00:00": Pair(
                                subject: "Основы российской государственности",
                                timeStart: "09:00:00",
                                timeEnd: "10:45:00",
                                lector: "Шевцов Александр Викторович",
                                type: "ПЗ",
                                room: "ГУК А-208",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "13:00:00": Pair(
                                subject: "Линейная алгебра и аналитическая геометрия",
                                timeStart: "10:45:00",
                                timeEnd: "12:15:00",
                                lector: "Бортаковский Александр Сергеевич",
                                type: "ЛК",
                                room: "ГУК В-214",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "14:45:00": Pair(
                                subject: "Дискретная математика",
                                timeStart: "14:45:00",
                                timeEnd: "16:15:00",
                                lector: "Нефедов Виктор Николаевич",
                                type: "ЛК",
                                room: "ГУК В-214",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "10.01.2025": DaySchedule(
                        day: "Пт",
                        pairs: [
                            "09:00:00": Pair(
                                subject: "Линейная алгебра и аналитическая геометрия",
                                timeStart: "09:00:00",
                                timeEnd: "10:30:00",
                                lector: "Пегачкова Ирина Александровна",
                                type: "ПЗ",
                                room: "ГУК Б-446",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "10:45:00": Pair(
                                subject: "Математический анализ",
                                timeStart: "10:45:00",
                                timeEnd: "12:15:00",
                                lector: "Симкина Анастасия Вячеславовна",
                                type: "ПЗ",
                                room: "ГУК Б-446",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "13:00:00": Pair(
                                subject: "Программирование на языке Python",
                                timeStart: "13:00:00",
                                timeEnd: "14:30:00",
                                lector: "Крылов Сергей Сергеевич",
                                type: "ЛК",
                                room: "2-314(2В)",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "14:45:00": Pair(
                                subject: "Физическая культура",
                                timeStart: "14:45:00",
                                timeEnd: "16:15:00",
                                lector: "Преподаватель не указан",
                                type: "ПЗ",
                                room: "--каф. 919",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    ),
                    "11.01.2025": DaySchedule(
                        day: "Сб",
                        pairs: [
                            "09:00:00": Pair(
                                subject: "Английский язык",
                                timeStart: "09:00:00",
                                timeEnd: "10:30:00",
                                lector: "Преподаватель не указан",
                                type: "ПЗ",
                                room: "Орш. Б-603",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "10:45:00": Pair(
                                subject: "История России",
                                timeStart: "10:45:00",
                                timeEnd: "12:15:00",
                                lector: "Балыш Андрей Николаевич",
                                type: "ЛК",
                                room: "Орш. В-301",
                                lms: "",
                                teams: "",
                                other: ""
                            ),
                            "13:00:00": Pair(
                                subject: "История России",
                                timeStart: "13:00:00",
                                timeEnd: "14:30:00",
                                lector: "Балыш Андрей Николаевич",
                                type: "ПЗ",
                                room: "Орш. А-424",
                                lms: "",
                                teams: "",
                                other: ""
                            )
                        ]
                    )
                ]
            ),
        ]
    }
}

