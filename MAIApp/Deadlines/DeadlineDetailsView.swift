import SwiftUI

struct DeadlineDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var taskDescription: String = ""
    @State private var endDate: Date = Date()
    @State private var priority: Priority = .normal
    @State private var isDatePickerVisible: Bool = false
    @Binding var deadlines: [Deadline]
    var deadline: Deadline
    
    
    init(deadlines: Binding<[Deadline]>, deadline: Deadline) {
            _deadlines = deadlines
            self.deadline = deadline
            _taskDescription = State(initialValue: deadline.description)
            _endDate = State(initialValue: deadline.date)
            _priority = State(initialValue: deadline.priority)
        }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Описание задачи")) {
                    TextEditor(text: $taskDescription)
                        .frame(height: 100)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .disableAutocorrection(false)
                }
                
                Section(header: Text("Дата окончания")) {
                    Button(action: {
                        isDatePickerVisible.toggle()
                    }) {
                        HStack {
                            Text("Выбранная дата:")
                                .font(.subheadline)
                            Spacer()
                            Text(endDate, style: .date)
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    if isDatePickerVisible {
                        DatePicker("Выберите дату", selection: $endDate, displayedComponents: [.date])
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                }
                
                Section(header: Text("Приоритет")) {
                    Picker("Приоритет", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { level in
                            Text(level.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button(action: {
                    deleteDeadline()
                    }, label: {
                        Text("Delete")
                 }
                )
            }

        }
    }
    func deleteDeadline() {
            // Находим индекс дедлайна
            if let index = deadlines.firstIndex(where: { $0.id == deadline.id }) {
                deadlines.remove(at: index) 
            }
            dismiss() // Закрываем экран
        }
}

enum Priority: String, CaseIterable {
    case low = "Низкий"
    case normal = "Средний"
    case high = "Высокий"
    
    var color: Color {
        switch self {
        case .low: return .green
        case .normal: return .orange
        case .high: return .red
        }
    }
}

//#Preview {
//    DeadlineDetailsView()
//}
