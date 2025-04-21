//
//  ScheduleContentViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 09.04.2025.
//

import Foundation
import SwiftUI

class ScheduleContentViewModel: ObservableObject {
    
    
    //    func scheduleContent(for daySchedule: DaySchedule) -> some View {
    //        let allLessons = sortedTimes(in: daySchedule).flatMap { timeKey, pairs in
    //            sortedSubjects(in: pairs).map { subject, pair in
    //                LessonItem(timeKey: timeKey, subject: subject, pair: pair)
    //            }
    //        }
    //
    //        return VStack {
    //            ForEach(allLessons) { lesson in
    //                VStack {
    //                    LessonRow(
    //                        pair: lesson.pair,
    //                        subject: lesson.subject,
    //                        formatTime: formatTime
    //                    )
    //
    //                    if lesson.id != allLessons.last?.id {
    //                        Rectangle()
    //                            .fill(.gray)
    //                            .opacity(0.25)
    //                            .frame(height: 1)
    //                    }
    //                }
    //            }
    //        }
    //        .overlay(
    //            RoundedRectangle(cornerRadius: 12)
    //                .stroke(.gray, lineWidth: 1)
    //                .opacity(0.25)
    //        )
    //        .onAppear {
    //            print("LessonsView загружает расписание для \(selectedDay)")
    //        }
    //    }
    //
    //
    //    private func sortedTimes(in daySchedule: DaySchedule) -> [(key: String, value: [String: Pair])] {
    //        daySchedule.pairs.sorted {
    //            guard let time1 = $0.key.toDate(),
    //                  let time2 = $1.key.toDate() else {
    //                return $0.key < $1.key
    //            }
    //            return time1 < time2
    //        }
    //    }
    //}
    
    
    // MARK: - Extension
    
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.date(from: self)
    }
    //Форматирует строку, делая первую букву каждого слова заглавной, остальные — строчными.
    func toCapitalizedCase() -> String {
        self
            .lowercased()
            .components(separatedBy: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }
}
