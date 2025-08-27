//
//  WorkoutCreationView.swift
//  MyWorkoutTracker
//
//  Created by Samuel Naumann on 2025-08-27.
//

import SwiftUI
import SwiftData

struct WorkoutCreationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var type = ""
    @State private var duration = 0.0
    @State private var notes = ""
    
    var onSave: (String, Double, String?) -> Void
    
    var body: some View {
        Form {
            TextField("Type", text: $type)
            
            Section("Duration (minutes)") {
                TextField("Duration", value: $duration, format: .number)
                    .keyboardType(.decimalPad)
            }

            TextField("Notes", text: $notes)
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    onSave(type, duration, notes.isEmpty ? nil : notes)
                    dismiss()
                }
                .disabled(type.isEmpty || duration <= 0)
            }
        }
    }
}

#Preview {
    WorkoutCreationView { type, duration, notes in
        print("Preview Save: type=\(type), duration=\(duration), notes=\(notes ?? "nil")")
    }
}
