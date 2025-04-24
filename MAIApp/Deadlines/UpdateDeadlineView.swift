import Foundation
import SwiftUI
import SwiftData

struct UpdateDeadlineView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var deadline: Deadline
    @Environment(\.modelContext) private var modelContext
    @State private var isEditable = false
    @State private var draftDate: Date
    
    init(deadline: Deadline) {
        self.deadline = deadline
        self._draftDate = State(initialValue: deadline.date)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Приоритет", selection: $deadline.priority) {
                        ForEach(Priority.allCases, id: \.self) { level in
                            Text(level.rawValue)
                        }
                    }
                    .disabled(!isEditable)
                }
                
                Section {
                    TextField("Название", text: $deadline.title)
                        .scrollDismissesKeyboard(.interactively)
                        .disabled(!isEditable)
                    TextField("Заметки", text: $deadline.details, axis: .vertical)
                        .disabled(!isEditable)
                }
                
                Section {
                    DatePicker("Дата", selection: $draftDate, in: Date()...)
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                        .disabled(!isEditable)
                }
                
                Section {
                    withAnimation {
                        Button("Удалить дедлайн", role: .destructive) {
                            modelContext.delete(deadline)
                            
                        }
                    }
                    
                    
                }
                
            }
            .navigationTitle("Просмотр")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Закрыть") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    if (!isEditable) {
                        Button("Изменить") {
                            isEditable = true
                        }
                        .fontWeight(.semibold)
                    } else {
                        Button("Сохранить") {
                            dismiss()
                            deadline.date = draftDate
                            try? modelContext.save()
                            isEditable = false
                            
                        }
                        .fontWeight(.semibold)
                    }
                }
            }
        }
    }

}


