import SwiftUI

struct ManyFacultyView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    
    var body: some View {
        VStack {
            if groupSelectionViewModel.faculties.isEmpty {
                Text("Нет доступных институтов")
                    .foregroundColor(.gray)
                    .padding()
            }
            else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(groupSelectionViewModel.faculties, id: \.self) { faculty in
                        OneFacultyView(faculty: faculty,
                                       isSelected: faculty == groupSelectionViewModel.selectedFaculty
                        )
                            .onTapGesture {
                                groupSelectionViewModel.selectedFaculty = faculty
                            }
                    }
                }
                .padding()
            }
        }
    }
}


