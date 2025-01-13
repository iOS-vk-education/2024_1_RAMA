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
        Deadline(priority: Priority.low, title: "низкий приоритет", description: "Низкий", date: Date.now),
        Deadline(priority: Priority.normal, title: "средний приоритет", description: "Средний", date: Date.now),
        Deadline(priority: Priority.high, title: "высокий приоритет", description: "Высокий", date: Date.now)
    ]
    @State private var isOpened = false
    @State var date = Date()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CalendarView(date: $date)
                    
                    ForEach(filterDeadlinesByDay(deadlines: deadlines, date: date)) { deadline in
                        DeadlineTitleView(deadline: deadline, deadlines: $deadlines)
                    }            
                    Spacer()
                }
                .padding()
                .navigationTitle("Дедлайны")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
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
            }
            
        }
    }
}
//    func deleteDeadline(at offsets: IndexSet) {
//            deadlines.remove(atOffsets: offsets)
//    }
    
//    func deleteDeadline(offsets: IndexSet) {
//        let filteredDeadlines = filterDeadlinesByDay(deadlines: deadlines, date: date)
//        for offset in offsets {
//            if let index = deadlines.firstIndex(where: { $0.id == filteredDeadlines[offset].id }) {
//                deadlines.remove(at: index)
//            }
//        }
//    }
//}
    


//#Preview {
//    DeadlinesView()
//}
