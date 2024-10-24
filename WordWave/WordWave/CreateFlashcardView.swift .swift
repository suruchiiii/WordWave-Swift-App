//
//  CreateFlashcardView.swift .swift
//  WordWave
//
//  Created by RPS on 19/10/24.
//
import SwiftUI

struct CreateFlashcardView: View {
    @ObservedObject var flashcardManager: FlashcardManager
    @State private var flashcardName: String = ""
    @State private var flashcardTranslation: String = ""
    @State private var exampleSentence: String = ""

    var body: some View {
        VStack {
            TextField("Flashcard Name", text: $flashcardName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Flashcard Translation", text: $flashcardTranslation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Example Sentence", text: $exampleSentence)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                addFlashcard()
            }) {
                Text("Save Flashcard")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
    
    private func addFlashcard() {
        let newFlashcard = Flashcard(
            name: flashcardName,
            translation: flashcardTranslation,
            exampleSentence: exampleSentence
            // isMastered defaults to false
        )
        flashcardManager.flashcards.append(newFlashcard)
        flashcardManager.saveFlashcards() // Save flashcards after adding
    }
}
