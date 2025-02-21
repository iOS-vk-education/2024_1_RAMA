import SwiftUI

struct ChooseGroupView: View {
    @EnvironmentObject var groupSelectionModel: GroupSelectionModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
                    VStack(alignment: .leading, spacing: 8) {
                        FacultyAndCourseView()
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Spacer().frame(height: 2)
                        LevelView()
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Spacer().frame(height: 2)
                        ScrollView{
                            if groupSelectionModel.selectedFaculty == "" || groupSelectionModel.selectedCourse == "" || groupSelectionModel.selectedLevel == "" {
                                FacultyErrorView()
                            }
                            else if groupSelectionModel.groups.isEmpty{
                                GroupErrorView()
                            }
                            else {
                                Spacer().frame(height: 2)
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



