import SwiftUI

struct WeekLessonsView: View {
    @ObservedObject var viewModel: LessonViewModel
    @ObservedObject var dateViewModel: DateViewModel
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(weekDays, id: \.self) { day in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(formattedDate(day))
                            .font(.headline)
                            .padding(.horizontal)
                        
                        if let daySchedule = viewModel.findLessonDay(for: day) {
                            LessonsList(daySchedule: daySchedule)
                        } else {
                            Text("Нет занятий")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            viewModel.loadScheduleForGroup(for: groupSelectionViewModel.selectedGroup)
        }
    }
    
    private var weekDays: [Date] {
        Array(dateViewModel.daysOfWeek(for: dateViewModel.selectedWeek).prefix(6))
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter.string(from: date)
    }
}

struct LessonsList: View {
    let daySchedule: DaySchedule

    var body: some View {
        VStack(spacing: 0) {
            let allLessons = sortedTimes(in: daySchedule).flatMap { timeKey, pairs in
                sortedSubjects(in: pairs).map { subject, pair in
                    LessonItem(timeKey: timeKey, subject: subject, pair: pair)
                }
            }
            
            ForEach(allLessons) { lesson in
                VStack {
                    LessonView(
                        timeRange: "\(formatTime(lesson.pair.timeStart)) – \(formatTime(lesson.pair.timeEnd))",
                        classroom: lesson.pair.room.values.first ?? "не указана",
                        lessonType: lesson.pair.type.keys.first ?? "не указан",
                        lessonName: lesson.subject,
                        lector: lesson.pair.lector.values.first?.toCapitalizedCase() ?? "не указан"
                    )
                    
                    if lesson.id != allLessons.last?.id {
                        Divider()
                            .opacity(0.25)
                    }
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        )
        .padding(.horizontal)
    }

    private func sortedTimes(in daySchedule: DaySchedule) -> [(key: String, value: [String: Pair])] {
        daySchedule.pairs.sorted {
            guard let t1 = $0.key.toDate(), let t2 = $1.key.toDate() else {
                return $0.key < $1.key
            }
            return t1 < t2
        }
    }

    private func sortedSubjects(in pairs: [String: Pair]) -> [(key: String, value: Pair)] {
        pairs.sorted { $0.key < $1.key }
    }

    private func formatTime(_ string: String) -> String {
        guard let date = string.toDate() else { return string }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private struct LessonItem: Identifiable {
        let id: String
        let timeKey: String
        let subject: String
        let pair: Pair

        init(timeKey: String, subject: String, pair: Pair) {
            self.timeKey = timeKey
            self.subject = subject
            self.pair = pair
            self.id = "\(timeKey)-\(subject)-\(pair.timeStart)-\(pair.timeEnd)"
        }
    }
}

struct LessonsForDayView: View {
    let daySchedule: DaySchedule

    var body: some View {
        VStack(spacing: 12) {
            ForEach(allLessons) { lesson in
                VStack(spacing: 8) {
                    LessonView(
                        timeRange: "\(formatTime(lesson.pair.timeStart)) – \(formatTime(lesson.pair.timeEnd))",
                        classroom: lesson.pair.room.values.first ?? "не указана",
                        lessonType: lesson.pair.type.keys.first ?? "не указан",
                        lessonName: lesson.subject,
                        lector: lesson.pair.lector.values.first?.toCapitalizedCase() ?? "не указан"
                    )

                    if lesson.id != allLessons.last?.id {
                        Divider().opacity(0.25)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }

    private var allLessons: [LessonItem] {
        sortedTimes(in: daySchedule).flatMap { timeKey, pairs in
            sortedSubjects(in: pairs).map { subject, pair in
                LessonItem(timeKey: timeKey, subject: subject, pair: pair)
            }
        }
    }

    private func sortedTimes(in daySchedule: DaySchedule) -> [(key: String, value: [String: Pair])] {
        daySchedule.pairs.sorted {
            guard let time1 = $0.key.toDate(),
                  let time2 = $1.key.toDate() else {
                return $0.key < $1.key
            }
            return time1 < time2
        }
    }

    private func sortedSubjects(in pairs: [String: Pair]) -> [(key: String, value: Pair)] {
        pairs.sorted {
            if $0.key == $1.key {
                return $0.value.timeStart < $1.value.timeStart
            } else {
                return $0.key < $1.key
            }
        }
    }

    private func formatTime(_ timeString: String) -> String {
        guard let date = timeString.toDate() else {
            return timeString
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private struct LessonItem: Identifiable {
        let id: String
        let timeKey: String
        let subject: String
        let pair: Pair
        
        init(timeKey: String, subject: String, pair: Pair) {
            self.timeKey = timeKey
            self.subject = subject
            self.pair = pair
            self.id = "\(timeKey)-\(subject)-\(pair.timeStart)-\(pair.timeEnd)"
        }
    }
}

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
}
