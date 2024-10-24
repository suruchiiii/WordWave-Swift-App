//
//  FlashcardManager.swift .swift
//  WordWave
//
//  Created by RPS on 19/10/24.
//

import Foundation
import Combine

class FlashcardManager: ObservableObject {
    @Published var flashcards: [Flashcard] = []
    private var currentFlashcardIndex: Int = 0
    
    // Progress tracking properties
    @Published var progress = ProgressModel(totalFlashcards: 0, masteredFlashcards: 0, quizScores: [])

    init() {
        loadFlashcards()
    }

    // Load flashcards from persistent storage
    func loadFlashcards() {
        // Implement your loading logic here
        // Update total flashcards count
        progress.totalFlashcards = flashcards.count
    }

    // Get the next flashcard
    func getNextFlashcard() -> Flashcard? {
        guard currentFlashcardIndex < flashcards.count else { return nil }
        let flashcard = flashcards[currentFlashcardIndex]
        currentFlashcardIndex += 1
        return flashcard
    }

    // Update flashcard performance
    func updateFlashcardPerformance(flashcard: Flashcard, isCorrect: Bool) {
        if let index = flashcards.firstIndex(where: { $0.id == flashcard.id }) {
            flashcards[index].isMastered = isCorrect
            if isCorrect {
                progress.masteredFlashcards += 1
            }
        }
    }

    // Reset the quiz
    func resetQuiz() {
        currentFlashcardIndex = 0
        // Reset mastered flashcards count for a new quiz
        progress.masteredFlashcards = 0
    }

    // Save flashcards (if applicable)
    func saveFlashcards() {
        // Implement saving logic here
    }

    // Record quiz score
    func recordQuizScore(score: Double) {
        progress.quizScores.append(score)
    }
}
