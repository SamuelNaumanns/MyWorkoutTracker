//
//  ContentView.swift
//  MyWorkoutTracker
//
//  Created by Samuel Naumann on 2025-08-19.
//

import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = WorkoutListViewModel()
    @State private var path = [Workout]()
    @State private var showingAddWorkout = false
    
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
                .onDelete {indexSet in
                    indexSet.map { workouts[$0] }.forEach { workout in
                        viewModel.deleteWorkout(context: modelContext, workout: workout)
                    }
                }
            }
            .navigationTitle("Workouts")
            .navigationDestination(for: Workout.self, destination: WorkoutEditingView.init)
            .toolbar {
                Button("Add Workout", systemImage: "plus") {
                    showingAddWorkout = true
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                NavigationStack {
                    WorkoutCreationView { type, duration, notes in
                        viewModel.addWorkout(context: modelContext, type: type, duration: duration, notes: notes)
                    }
                }

            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        
        return WorkoutListView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
    }
}
