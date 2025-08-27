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
    var duration : Double
    var notes : String?
    
    init(id: UUID = UUID(), date: Date = .now, type: String = "", duration: Double = 15, notes: String? = nil) {
        self.id = id
        self.date = date
        self.type = type
        self.duration = duration
        self.notes = notes
    }
}
