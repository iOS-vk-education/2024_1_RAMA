//
//  UpdateDeadlineView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 10.12.2024.
//

import SwiftUI

struct UpdateDeadlineView: View {
    @Environment(\.dismiss) private var dismiss
    var deadline: Deadline
    @Binding var deadlines: [Deadline]
    
    @State private var title: String
    @State private var description: String
    @State private var date: Date
    @State private var priority: Priority
    
    @State private var isEditable = false
    
    
    init(deadline: Deadline, deadlines: Binding<[Deadline]>) {
        self.deadline = deadline
        _deadlines = deadlines
        _title = State(initialValue: deadline.title)
        _description = State(initialValue: deadline.description)
        _date = State(initialValue: deadline.date)
        _priority = State(initialValue: deadline.priority)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Приоритет", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { level in
                            Text(level.rawValue)
                        }
                    }
                    .disabled(!isEditable)
                }
                
                Section {
                    TextField("Название", text: $title)
                        .scrollDismissesKeyboard(.interactively)
                        .disabled(!isEditable)
                    TextField("Заметки", text: $description, axis: .vertical)
                        .disabled(!isEditable)
                }
                
                Section {
                    DatePicker("Дата", selection: $date)
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                        .disabled(!isEditable)
                }
                
                Section {
                    Button("Удалить дедлайн", role: .destructive) {
                        deleteDeadline()
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
                            isEditable = true;
                        }
                        .fontWeight(.semibold)
                    } else {
                        Button("Сохранить") {
                            saveChanges()
                        }
                        .fontWeight(.semibold)
                    }
                }
            }
        }
    }
    private func deleteDeadline() {
        dismiss()
        deadlines.removeAll{
            $0.id == deadline.id
        }
        
    }
    
    private func saveChanges() {
        isEditable = false
        if let i = deadlines.firstIndex(where: { $0.id == deadline.id }) {
            deadlines[i] = Deadline(priority: priority, title: title, description: description, date: date)
            print("обновлен дедлайн: \(deadlines[i])")
        }
        else {
            print("ошибка")
        }
    }
//    private func saveChanges() {
//        if let index = deadlines.firstIndex(where: {
//            $0.id == deadline.id
//            }
//        )
//        {
//            deadlines[index] = deadline
//        }
//        isEditable = false
//    }
}




//#Preview {
//    UpdateDeadlineView(deadline: Deadline(priority: Priority.low, title: "Title", description: "Desc", date: Date.now))
//}
