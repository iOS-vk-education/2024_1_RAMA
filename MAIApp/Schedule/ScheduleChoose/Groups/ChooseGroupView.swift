import SwiftUI

struct ChooseGroupView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
                    VStack(alignment: .leading, spacing: 8) {
                        FacultyAndCourseView()
                        Spacer().frame(height: 2)
                        LevelView()
                        Spacer().frame(height: 2)
                        ScrollView{
                            if groupSelectionModel.selectedFaculty == "" {
                                FacultyErrorView()
                            }
                            else if groupSelectionModel.selectedCourse == "" {
                                CourseErrorView()
                            }
                            else if groupSelectionModel.selectedLevel == "" {
                                LevelErrorView()
                            }
                            else if groupSelectionModel.groups.isEmpty{
                                GroupErrorView()
                            }
                            else {
                                ManyGroupsView(
                                    groupSelectionModel: groupSelectionModel,
                                    onGroupSelected: { group in
                                        groupSelectionModel.selectedGroup = group.name
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                )
                            }
                        }
                        Spacer()
                    }
                    .task {
                                await groupSelectionModel.loadGroups()
                            }
                    .padding()
                    .navigationTitle("Группа")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}



