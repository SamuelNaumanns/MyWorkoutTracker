//
//  Workout.swift
//  MyWorkoutTracker
//
//  Created by Samuel Naumann on 2025-08-26.
//

import Foundation
import SwiftData

@Model
class Workout {
    var id: UUID
    var date : Date
    var type : String
    var Duration : Double
    var notes : String?
    
    init(id: UUID = UUID(), date: Date = .now, type: String = "", Duration: Double = 0.15, notes: String? = nil) {
        self.id = id
        self.date = date
        self.type = type
        self.Duration = Duration
        self.notes = notes
    }
}
