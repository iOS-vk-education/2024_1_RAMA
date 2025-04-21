import Foundation

struct WeekData: Identifiable {
    let id = UUID()
    let number: Int
    let startDate: Date   // Понедельник
    let endDate: Date     // Воскресенье
    let dates: [Date]
    var displayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return "\(formatter.string(from: startDate)) – \(formatter.string(from: endDate))"
    }
}
