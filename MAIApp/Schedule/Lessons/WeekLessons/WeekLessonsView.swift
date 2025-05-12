import SwiftUI

struct WeekLessonsView: View {
    @Binding var selectedDay: Date
    @Binding var selectedGroup: String
    @ObservedObject var viewModel: LessonViewModel
    @State private var error: Error?
    var scheduleMode: ScheduleMode
    
    private var weekDays: [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: selectedDay))!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    private let headerDateFormatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateFormat = "d MMMM"

        return formatter
    }()

    private let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateFormat = "EEEE"

        return formatter
    }()
    
    // MARK: - Секция для одного дня
    private func dayScheduleSection(for date: Date) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            dayHeader(for: date)
            if let daySchedule = viewModel.getSchedule(for: date) {
                scheduleContent(for: daySchedule)
            } else {
                Text("Нет занятий")
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Заголовок дня
       private func dayHeader(for date: Date) -> some View {
           HStack {
               VStack(alignment: .leading) {
                   Text(DateFormatter.headerDate.string(from: date))
                       .font(.headline)
                   
                   Text(DateFormatter.weekday.string(from: date))
                       .font(.subheadline)
                       .foregroundColor(.secondary)
               }
               
               Spacer()
               
               if Calendar.current.isDate(date, inSameDayAs: Date()) {
                   Text("Сегодня")
                       .font(.caption)
                       .foregroundColor(.white)
                       .padding(5)
                       .background(Capsule().fill(Color.blue))
               }
           }
           .padding(.bottom, 8)
       }
    
    var body: some View {
        ScrollView {
            VStack {
                if viewModel.groupSchedule != nil {
                    if let selectedLessonDay = viewModel.findLessonDay(for: selectedDay) {
                        scheduleContent(for: selectedLessonDay)
                    } else {
                        placeholderView
                    }
                } else if error != nil {
                    placeholderView
                } else {
                    loadingSkeleton
                }
            }
        }
        .onAppear {

            viewModel.loadScheduleForGroup(for: selectedGroup)


        }
    }
    
    
    
    // MARK: - View Components
    private struct LessonRow: View {
        let pair: Pair
        let subject: String
        let formatTime: (String) -> String
        
        var body: some View {
            VStack {
                LessonView(
                    timeRange: "\(formatTime(pair.timeStart)) – \(formatTime(pair.timeEnd))",
                    classroom: pair.room.values.first ?? "не указана",
                    lessonType: pair.type.keys.first ?? "не указан",
                    lessonName: subject,
                    lector: pair.lector.values.first?.toCapitalizedCase() ?? "не указан"
                )
            }
        }
    }

    private func scheduleContent(for daySchedule: DaySchedule) -> some View {
        let allLessons = sortedTimes(in: daySchedule).flatMap { timeKey, pairs in
            sortedSubjects(in: pairs).map { subject, pair in
                LessonItem(timeKey: timeKey, subject: subject, pair: pair)
            }
        }
        
        return VStack {
            ForEach(allLessons) { lesson in
                VStack {
                    LessonRow(
                        pair: lesson.pair,
                        subject: lesson.subject,
                        formatTime: formatTime
                    )
                    
                    if lesson.id != allLessons.last?.id {
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
    }
    
    // MARK: - Loading Skeleton
    private var loadingSkeleton: some View {
        VStack(spacing: 16) {
            ForEach(0..<5) { _ in
                SkeletonView()
                    .frame(height: 80)
                    .cornerRadius(12)
            }
        }
        .padding()
        .redacted(reason: .placeholder)
    }
    
    private struct SkeletonView: View {
        @State private var isAnimating = false
        
        var body: some View {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.gray.opacity(0.1),
                            Color.gray.opacity(0.3),
                            Color.gray.opacity(0.1)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .opacity(isAnimating ? 1 : 0.5)
                .animation(
                    Animation.easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }
        }
    }
    
    // MARK: - Placeholder View
    private var placeholderView: some View {
        VStack {
            Spacer()
            Image("error_schedule")
                .padding(.top, 100)
            Text("Данные не найдены :(")
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .padding(.top, 15)
            if let error = error {
                Text("Ошибка: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .font(.system(size: 12, weight: .light, design: .rounded))
            } else {
                Text("Расписание ещё не выложили, либо в расписании ошибка.")
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .light, design: .rounded))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Sorting Helpers
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
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        return outputFormatter.string(from: date)
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
    
    static let headerDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    static let weekday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
}
