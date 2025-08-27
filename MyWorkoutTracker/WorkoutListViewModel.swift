//
//  WorkoutListViewModel.swift
//  MyWorkoutTracker
//
//  Created by Samuel Naumann on 2025-08-27.
//

import Foundation
import SwiftData

class WorkoutListViewModel {
    func addWorkout(context: ModelContext, type: String, duration: Double, notes: String?) {
        guard !type.isEmpty, duration > 0 else { return }
        let workout = Workout(type: type, duration: duration, notes: notes)
        context.insert(workout)
        try? context.save()
    }
    
    func deleteWorkout(context: ModelContext, workout: Workout) {
        context.delete(workout)
        try? context.save()
    }
}
