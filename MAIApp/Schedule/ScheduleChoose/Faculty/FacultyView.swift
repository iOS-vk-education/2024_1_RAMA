import SwiftUI

struct FacultyView: View {
    let faculty: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("институт")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(faculty.isEmpty
                     ? "Не выбран"
                     : faculty
                )
                    .font(.headline)
            }
            .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
}

