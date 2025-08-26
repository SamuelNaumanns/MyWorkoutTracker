//
//  ContentView.swift
//  MyWorkoutTracker
//
//  Created by Samuel Naumann on 2025-08-19.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Workout.date, order: .reverse) private var workouts: [Workout]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workouts) { workout in
                    VStack(alignment: .leading) {
                        Text(workout.type)
                            .font(.headline)
                        
                        Text(workout.date, style: .date)
                        
                        Text("\(workout.duration, specifier: "%.0f") min")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear workouts", role: .destructive, action: clearWorkouts)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add workouts", action: addWorkouts)
                }
            }
        }
    }
    
    func clearWorkouts() {
        for workout in workouts {
            modelContext.delete(workout)
        }
    }
    
    func addWorkouts() {
        let push = Workout(type: "Push", Duration: 45)
        let pull = Workout(type: "Pull", Duration: 55)
        let legs = Workout(type: "Legs", Duration: 75)

        modelContext.insert(push)
        modelContext.insert(pull)
        modelContext.insert(legs)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)

        let push = Workout(type: "Push", Duration: 45)
        let pull = Workout(type: "Pull", Duration: 55)
        let legs = Workout(type: "Legs", Duration: 75)
        
        container.mainContext.insert(push)
        container.mainContext.insert(pull)
        container.mainContext.insert(legs)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
    }
}
