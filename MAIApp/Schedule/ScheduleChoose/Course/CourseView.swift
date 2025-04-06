import SwiftUI

struct CourseView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let course: String
    
    var body: some View {
        NavigationStack {
            HStack {
                if !groupSelectionViewModel.selectedFaculty.isEmpty {
                    
                    NavigationLink(destination: ChooseCourseView(groupSelectionViewModel: groupSelectionViewModel)) {
                        VStack(alignment: .leading) {
                            Text("курс")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(groupSelectionViewModel.selectedCourse.isEmpty
                                 ? "Не выбран"
                                 : groupSelectionViewModel.selectedCourse)
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
