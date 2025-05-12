import SwiftUI

struct ChooseGroupView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
                    VStack(alignment: .leading, spacing: 8) {
                        FacultyAndCourseView(groupSelectionViewModel: groupSelectionViewModel)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Spacer().frame(height: 2)
                        LevelView()
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Spacer().frame(height: 2)
                        ScrollView{
                            if groupSelectionViewModel.selectedFaculty == "" || groupSelectionViewModel.selectedCourse == "" || groupSelectionViewModel.selectedLevel == "" {
                                FacultyErrorView()
                            }
                            else if groupSelectionViewModel.groups.isEmpty{
                                GroupErrorView()
                            }
                            else {
                                Spacer().frame(height: 2)
                                ManyGroupsView(groupSelectionViewModel: groupSelectionViewModel)
                            }
                        }
                        Spacer()
                    }
                    .task {
                        groupSelectionViewModel.loadDecodedGroups()
                    }
                    .onChange(of: groupSelectionViewModel.selectedGroup) {_, newGroup in
                        if !newGroup.isEmpty {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding()
                    .navigationTitle("Группа")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}



