//
//  ProgressModel.swift
//  WordWave
//
//  Created by RPS on 19/10/24.
//

import Foundation
struct ProgressModel {
    var totalFlashcards: Int
    var masteredFlashcards: Int
    var quizScores: [Double] // Store scores for each quiz session
    
    var retentionRate: Double {
        guard totalFlashcards > 0 else { return 0.0 }
        return Double(masteredFlashcards) / Double(totalFlashcards) * 100.0
    }
    
    var averageScore: Double {
        guard !quizScores.isEmpty else { return 0.0 }
        return quizScores.reduce(0, +) / Double(quizScores.count)
    }
}
