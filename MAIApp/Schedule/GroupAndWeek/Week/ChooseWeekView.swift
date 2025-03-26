import SwiftUI

struct ChooseWeekView: View {
    @ObservedObject var weekViewModel: WeekViewModel
    @Binding var weekNumber: Int
    @Binding var selectedDay: Date
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
            NavigationStack {
                ScrollViewReader { placement in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(weekViewModel.allWeeksInYear(), id: \.number) { week in
                                OneWeekView(
                                    week: week.displayText,
                                    isSelected: week.number == weekNumber
                                )
                                .id(week.number)
                                .onTapGesture {
                                    weekNumber = week.number
                                    selectedDay = week.startDate
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
                            placement.scrollTo(weekNumber, anchor: .center)
                        }
                    }
                }
            }
        }
}


