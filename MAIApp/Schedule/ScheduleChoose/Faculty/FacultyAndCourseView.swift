import SwiftUI

struct FacultyAndCourseView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 0) {
            
            NavigationLink(destination: ChooseFacultyView()) {
                FacultyView(faculty: groupSelectionModel.selectedFaculty)
            }
            Rectangle()
                .fill(.gray)
                .opacity(0.25)
                .frame(width: 1)
            
            
            if !groupSelectionModel.selectedFaculty.isEmpty {
                            NavigationLink(destination: ChooseCourseView()) {
                                CourseView(course: groupSelectionModel.selectedCourse)
                            }
            } else {
                CourseView(course: groupSelectionModel.selectedCourse)
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


