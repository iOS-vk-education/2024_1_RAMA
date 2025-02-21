import SwiftUI

struct ManyFacultyView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    var body: some View {
        VStack {
            if groupSelectionModel.faculties.isEmpty {
                Text("Нет доступных институтов")
                    .foregroundColor(.gray)
                    .padding()
            }
            else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(groupSelectionModel.faculties, id: \.self) { faculty in
                        OneFacultyView(faculty: faculty,
                                       isSelected: faculty == groupSelectionModel.selectedFaculty
                                    )
                            .onTapGesture {
                                groupSelectionModel.selectedFaculty = faculty
                            }
                    }
                }
                .padding()
            }
        }
    }
}


