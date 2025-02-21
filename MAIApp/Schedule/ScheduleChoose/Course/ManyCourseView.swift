import SwiftUI

struct ManyCourseView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(groupSelectionModel.courses, id: \.self) { course in
                OneCourseView(course: course,
                              isSelected: course == groupSelectionModel.selectedCourse
                            )
                    .onTapGesture {
                        groupSelectionModel.selectedCourse = course
                    }
            }
        }
        .padding()
    }
}

