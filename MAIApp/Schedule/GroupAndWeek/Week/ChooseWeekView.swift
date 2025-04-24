import SwiftUI
struct ChooseWeekView: View {
    @ObservedObject var dateViewModel: DateViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            NavigationStack {
                ScrollViewReader { placement in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(dateViewModel.allWeeks, id: \.number) { week in
                                OneWeekView(
                                    week: week.displayText,
                                    isSelected: week.number == dateViewModel.selectedWeek
                                )
                                .id(week.number)
                                .onTapGesture {
                                    dateViewModel.selectedWeek = week.number
                                    dismiss()
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Неделя")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        DispatchQueue.main.async {
                            placement.scrollTo(dateViewModel.selectedWeek, anchor: .center)
                        }
                        
                    }
                }
            }
        }
}


