import SwiftUI

struct ChooseGroupView: View {
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @ObservedObject var dateViewModel: DateViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
                    VStack(alignment: .leading, spacing: 8) {
                        FacultyAndCourseView(groupSelectionViewModel: groupSelectionViewModel)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Spacer().frame(height: 2)
                        LevelView(groupSelectionViewModel: groupSelectionViewModel)
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
                            dateViewModel.loadWeeksForGroup(for: newGroup)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding()
                    .navigationTitle("Группа")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                resetGroupSelection()
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Сбросить группу")
                            }
                        }
                    }
        }
    }
    fileprivate func resetGroupSelection() {
        groupSelectionViewModel.selectedFaculty = ""
        groupSelectionViewModel.selectedCourse = ""
        groupSelectionViewModel.selectedLevel = ""
        groupSelectionViewModel.selectedGroup = ""
        dateViewModel.selectedWeek = 0
    }
}



