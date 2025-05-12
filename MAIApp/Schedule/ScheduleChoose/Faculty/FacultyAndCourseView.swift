import SwiftUI

struct FacultyAndCourseView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 0) {
            
            NavigationLink(destination: ChooseFacultyView(groupSelectionViewModel: groupSelectionViewModel)) {
                FacultyView(faculty: groupSelectionViewModel.selectedFaculty)
            }
            Rectangle()
                .fill(.gray)
                .opacity(0.25)
                .frame(width: 1)
            
            
            if !groupSelectionViewModel.selectedFaculty.isEmpty {
                NavigationLink(destination: ChooseCourseView(groupSelectionViewModel: groupSelectionViewModel)) {
                    CourseView(groupSelectionViewModel: groupSelectionViewModel, course: groupSelectionViewModel.selectedCourse)
                            }
            } else {
                CourseView(groupSelectionViewModel: groupSelectionViewModel, course: groupSelectionViewModel.selectedCourse)
                    .disabled(true)
                    .opacity(0.5)
            }
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.25)
                )
    }
}


