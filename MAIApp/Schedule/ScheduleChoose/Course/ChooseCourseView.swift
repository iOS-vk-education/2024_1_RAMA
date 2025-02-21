import SwiftUI


struct ChooseCourseView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyCourseView()
                }
                .padding()
                .navigationTitle("Курс")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: groupSelectionModel.selectedCourse) { _, _ in
            dismiss()
            groupSelectionModel.selectedLevel = ""
        }
    }
}

