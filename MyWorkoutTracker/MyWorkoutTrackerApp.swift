//
//  MyWorkoutTrackerApp.swift
//  MyWorkoutTracker
//
//  Created by Samuel Naumann on 2025-08-19.
//

import SwiftUI
import SwiftData

@main
struct MyWorkoutTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Workout.self)
    }
}
