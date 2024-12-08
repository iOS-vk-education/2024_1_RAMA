import SwiftUI

struct Deadline: Identifiable {
    let id = UUID()
    let priority: Priority
    let title: String
    let description: String
    let date: Date
}

func filterDeadlinesByDay(deadlines: [Deadline], date: Date) -> [Deadline] {
    let calendar = Calendar.current

    return deadlines.filter { deadline in
        calendar.isDate(deadline.date, inSameDayAs: date)
    }
}

struct DeadlinesView: View {
    @State private var deadlines = [
        Deadline(priority: Priority.low, title: "Title", description: "Desc", date: Date.now),
        Deadline(priority: Priority.normal, title: "Title", description: "Desc", date: Date.now - 60 * 60),
        Deadline(priority: Priority.high, title: "Title", description: "Desc", date: Date.now - 60 * 10)
    ]
    @State private var isOpened = false
    @State var date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView(date: $date)
                
                ForEach(filterDeadlinesByDay(deadlines: deadlines, date: date)) { deadline in
                    //                    NavigationLink(destination: DeadlineDetailsViewWrapper(deadline: deadline)) {
                    //                        DeadlineTitleView(color: deadline.color, text: deadline.title, time: deadline.time)
                    //                    }
                    DeadlineTitleView(deadline: deadline)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Дедлайны")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //                ToolbarItem(placement: .topBarLeading) {
                //                    Button {
                //                        print("magnifyingglass button clicked!")
                //                    } label: {
                //                        Image(systemName: "magnifyingglass")
                //                    }
                //                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isOpened = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isOpened) {
                CreateDeadlineView(deadlines: $deadlines)
            }
            .onChange(of: date) { oldValue, newValue in
                print("date change")
            }
        }
    }
}

//struct DeadlineDetailsViewWrapper: View {
//    let deadline: Deadline
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        DeadlineDetailsView()
//            .navigationTitle(deadline.title)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Сохранить") {
//                        print("Данные сохранены")
//                        dismiss()
//                    }
//                }
//            }
//    }
//}




#Preview {
    DeadlinesView()
}
