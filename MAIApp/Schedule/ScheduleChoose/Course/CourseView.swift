import SwiftUI

struct CourseView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.colorScheme) var colorScheme
    let course: String
    var body: some View {
        NavigationStack {
            HStack {
                if !groupSelectionModel.selectedFaculty.isEmpty {
                    
                    NavigationLink(destination: ChooseCourseView()) {
                        VStack(alignment: .leading) {
                            Text("курс")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(groupSelectionModel.selectedCourse.isEmpty
                                 ? "Не выбран"
                                 : groupSelectionModel.selectedCourse)
                            .font(.headline)
                            
                            
                        }
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Spacer()
                    }
                }
                
                else {
                    VStack(alignment: .leading) {
                        Text("курс")
                            .font(.caption)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Text("Выберите институт")
                            .font(.headline)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                    }
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
        }
        
    }
}
