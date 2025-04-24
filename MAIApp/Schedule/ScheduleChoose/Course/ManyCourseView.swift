import SwiftUI

struct ManyCourseView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(groupSelectionViewModel.courses, id: \.self) { course in
                OneCourseView(course: course,
                              isSelected: course == groupSelectionViewModel.selectedCourse
                            )
                    .onTapGesture {
                        groupSelectionViewModel.selectedCourse = course
                    }
            }
        }
        .padding()
    }
}

