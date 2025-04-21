import SwiftUI

struct GroupAndWeekView: View {
    @Binding var weekNumber: Int
    @Binding var selectedDay: Date
    @ObservedObject var groupSelectionViewModel: GroupSelectionViewModel
    @ObservedObject var weekViewModel: WeekViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                NavigationLink(destination: ChooseGroupView(groupSelectionViewModel: groupSelectionViewModel, weekViewModel: weekViewModel)) {
                    GroupView(groupSelectionViewModel: groupSelectionViewModel, group: groupSelectionViewModel.selectedGroup)
                }
                .foregroundStyle(colorScheme == .dark ? .white : .black)
//                Rectangle()
//                    .fill(.gray)
//                    .opacity(0.25)
//                    .frame(width: 1)
                NavigationLink(destination: ChooseWeekView(weekViewModel: weekViewModel, weekNumber: $weekNumber, selectedDay: $selectedDay)) {
                    WeekView(weekNumber: $weekNumber, weekViewModel: weekViewModel)
                }
                .foregroundColor(groupSelectionViewModel.selectedGroup.isEmpty ? .gray : .white)
                .disabled(groupSelectionViewModel.selectedGroup.isEmpty)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            )

            
        }
        .onAppear {
            print("📱 GroupAndWeekView появился, weekNumber: \(weekNumber), selectedDay: \(selectedDay)")
        }
    }
    
}

//#Preview {
//    GroupAndWeekView(
//        weekNumber: .constant(1),
//        selectedDay: .constant(Date()),
//        groupSelectionViewModel: GroupSelectionViewModel(),
//        weekViewModel: WeekViewModel()
//    )
//}
