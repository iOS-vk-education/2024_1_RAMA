import SwiftUI

struct ChooseFacultyView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ManyFacultyView()
                }
                .padding()
                .navigationTitle("Институт")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: groupSelectionModel.selectedFaculty) { _, _ in
            dismiss()
            groupSelectionModel.selectedCourse = ""
            groupSelectionModel.selectedLevel = ""
            groupSelectionModel.selectedGroup = ""
        }
    }
}

//struct ChooseFacultyView: View {
//    @Binding var selectedFaculty: Faculty
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 8) {
//                    ManyFacultyView(viewModel: ManyFacultyViewModel(selectedFaculty: $selectedFaculty, model: .init()))
//                    Spacer()
//                }
//                .padding()
//                .navigationTitle("Институт")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//        .onChange(of: selectedFaculty) { newFaculty, _ in
//            dismiss()
//        }
//    }
//}

//#Preview {
//    ChooseFacultyView()
//}

