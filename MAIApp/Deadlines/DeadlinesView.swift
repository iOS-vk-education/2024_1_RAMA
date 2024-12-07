import SwiftUI

struct DeadlinesView: View {
    @State private var deadlines = [
        Deadline(color: .orange, title: "Первый дедлайн", time: "14:00"),
        Deadline(color: .blue, title: "Второй дедлайн", time: "16:00"),
        Deadline(color: .red, title: "Третий дедлайн", time: "18:00"),
    ]
    @State private var isShowingNewDeadlineView = false 
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
                
                ForEach(deadlines) { deadline in
                    NavigationLink(destination: DeadlineDetailsViewWrapper(deadline: deadline)) {
                        DeadlineTitleView(color: deadline.color, text: deadline.title, time: deadline.time)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Дедлайны")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("magnifyingglass button clicked!")
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingNewDeadlineView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingNewDeadlineView) {
                DeadlineNewView()
            }
        }
    }
}

struct Deadline: Identifiable {
    let id = UUID()
    let color: Color
    let title: String
    let time: String
}

struct DeadlineDetailsViewWrapper: View {
    let deadline: Deadline
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        DeadlineDetailsView()
            .navigationTitle(deadline.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        print("Данные сохранены")
                        dismiss()
                    }
                }
            }
    }
}




#Preview {
    DeadlinesView()
}
