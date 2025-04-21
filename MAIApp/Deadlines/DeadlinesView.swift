import SwiftUI
import SwiftData

struct DeadlinesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Deadline.date) private var deadlines: [Deadline]
    @State private var selectedDate = Date()
    @State private var isOpened = false

    var body: some View {
        NavigationStack {
            
                VStack {
                    CalendarView(date: $selectedDate)
                    ScrollView {
                        ForEach(filteredDeadlines) { deadline in
                            DeadlineTitleView(deadline: deadline)
                        }
                        Spacer()
                        }
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
                    CreateDeadlineView(selectedDate: $selectedDate)
                }
            
            
        }
    }
    private var filteredDeadlines: [Deadline] {
        deadlines.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
}



