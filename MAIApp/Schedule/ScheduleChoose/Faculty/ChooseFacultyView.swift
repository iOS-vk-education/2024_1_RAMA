import SwiftUI

struct ChooseFacultyView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyFacultyView(groupSelectionViewModel: groupSelectionViewModel)
                }
                .padding()
                .navigationTitle("Институт")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: groupSelectionViewModel.selectedFaculty) { _, _ in
            dismiss()
            groupSelectionViewModel.selectedCourse = ""
            groupSelectionViewModel.selectedLevel = ""
            groupSelectionViewModel.selectedGroup = ""
        }
    }
}

