//
//  SwiftUIView.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 07.12.2024.
//

import SwiftUI

struct CreateDeadlineView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Binding var selectedDate: Date
    @State private var title = ""
    @State private var details = ""
    @State private var date = Date()
    @State private var priority: Priority = .low

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Приоритет", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) { level in
                            Text(level.rawValue)
                        }
                    }
                }
                
                Section {
                    TextField("Название", text: $title)
                        .scrollDismissesKeyboard(.interactively)
                    TextField("Заметки", text: $details, axis: .vertical)
                }
                
                Section {
                    DatePicker("Дата", selection: $selectedDate, in: Date()...)
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                }
            }
            .navigationTitle("Создать")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отменить") {
                        print("Отменить button clicked!")
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить") {
                        saveDeadline()
                    }
                    .disabled(title.isEmpty)
                    .fontWeight(.semibold)
                }
            }
        }
    }
    private func saveDeadline() {
        let newDeadline = Deadline(
            priority: priority,
            title: title,
            details: details,
            date: selectedDate
        )
        modelContext.insert(newDeadline)
        dismiss()
    }
}


