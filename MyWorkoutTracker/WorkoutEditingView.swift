//
//  WorkoutDetailView.swift
//  MyWorkoutTracker
//
//  Created by Samuel Naumann on 2025-08-26.
//

import SwiftUI
import SwiftData

struct WorkoutEditingView: View {
    @Bindable var workout: Workout
    
    var body: some View {
        Form {
            TextField("Workout Type", text: $workout.type)
            
            Section("Duration (minutes)") {
                TextField("Duration (minutes)", value: $workout.duration, format: .number)
                    .keyboardType(.decimalPad)
            }
            
            TextField("Notes", text: Binding(
                get: { workout.notes ?? "" },
                set: { workout.notes = $0.isEmpty ? nil : $0 }
            ))

        }
        .navigationTitle("Edit workout")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        
        let example = Workout()
        return WorkoutEditingView(workout: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
    
}
