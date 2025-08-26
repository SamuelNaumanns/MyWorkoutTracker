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
    @State private var path = [Workout]()
    
    @Query(sort: \Workout.date, order: .reverse) private var workouts: [Workout]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(workouts) { workout in
                    NavigationLink(value: workout) {
                        VStack(alignment: .leading) {
                            Text(workout.type)
                                .font(.headline)
                            
                            Text(workout.date, style: .date)
                            
                            Text("\(workout.duration, specifier: "%.0f") min")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: clearWorkouts)
            }
            .navigationTitle("Workouts")
            .navigationDestination(for: Workout.self, destination: WorkoutDetailView.init)
            .toolbar {
                Button("Add Workout", systemImage: "plus", action: addWorkout)
            }
        }
    }
    
    func clearWorkouts(_ indexSet: IndexSet) {
        for i in indexSet {
            let workout = workouts[i]
            modelContext.delete(workout)
        }
    }
    
    func addWorkout() {
        let workout = Workout()
        modelContext.insert(workout)
        	path = [workout]
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
    }
}
