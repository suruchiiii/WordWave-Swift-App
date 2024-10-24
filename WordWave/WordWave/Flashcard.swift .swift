//
//  Flashcard.swift .swift
//  WordWave
//
//  Created by RPS on 19/10/24.
//
import Foundation

struct Flashcard: Identifiable {
    let id: UUID
    let name: String
    let translation: String
    let exampleSentence: String
    var isMastered: Bool = false  // New property to track mastery
    
    init(id: UUID = UUID(), name: String, translation: String, exampleSentence: String) {
        self.id = id
        self.name = name
        self.translation = translation
        self.exampleSentence = exampleSentence
    }
}
