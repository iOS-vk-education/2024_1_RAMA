import SwiftUI

struct ChooseCourseView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyCourseView(groupSelectionViewModel: groupSelectionViewModel)
                }
                .padding()
                .navigationTitle("Курс")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: groupSelectionViewModel.selectedCourse) { _, _ in
            dismiss()
            groupSelectionViewModel.selectedLevel = ""
        }
    }
}

