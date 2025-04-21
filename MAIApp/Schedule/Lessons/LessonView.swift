import SwiftUI

struct LessonView: View {
    let timeRange: String
    let classroom: String
    let lessonType: String
    let lessonName: String
    let lector: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack (spacing: 4){
                BadgeComponentView(content: timeRange)
                Spacer()
                BadgeComponentForPlaceTypeView(type: lessonType, place: classroom)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(lessonName)
                    .font(.headline)
                if lector.isEmpty {
                    Text("Преподаватель не указан")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                else {
                    Text(lector)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(12)
    }
}

