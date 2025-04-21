

//struct ChooseWeekView: View {
//    @ObservedObject var weekViewModel: WeekViewModel
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        NavigationStack {
//            ScrollViewReader { proxy in
//                contentView
//                    .onAppear {
//                        scrollToSelectedWeek(using: proxy)
//                    }
//            }
//        }
//    }
//    
//    private var contentView: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 8) {
//                weeksList
//            }
//            .padding()
//        }
//        .navigationTitle("Неделя")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//    
//    private var weeksList: some View {
//        ForEach(weekViewModel.allWeeks, id: \.number) { week in
//            weekRow(for: week)
//        }
//    }
//    
//    private func weekRow(for week: WeekData) -> some View {
//        OneWeekView(
//            week: week.displayText,
//            isSelected: week.number == weekViewModel.selectedWeek
//        )
//        .id(week.number)
//        .onTapGesture(perform: { selectWeek(week) })
//    }
//    
//    private func selectWeek(_ week: WeekData) {
//        weekViewModel.selectedWeek = week.number
//        dismiss()
//    }
//    
//    private func scrollToSelectedWeek(using proxy: ScrollViewProxy) {
//        DispatchQueue.main.async {
//            proxy.scrollTo(weekViewModel.selectedWeek, anchor: .center)
//        }
//    }
//}
import SwiftUI
struct ChooseWeekView: View {
    @ObservedObject var weekViewModel: WeekViewModel
    @Binding var weekNumber: Int
    @Binding var selectedDay: Date
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
//    var selectedWeek
    var body: some View {
            NavigationStack {
                ScrollViewReader { placement in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(weekViewModel.allWeeks, id: \.number) { week in
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


