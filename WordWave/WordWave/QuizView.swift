//
//  QuizView.swift
//  WordWave
//
//  Created by RPS on 19/10/24.
//

import SwiftUI
import Combine

struct QuizView: View {
    @ObservedObject var flashcardManager: FlashcardManager
    @Binding var quizScore: Int
    @Binding var showSummary: Bool
    @State private var currentFlashcard: Flashcard?
    @State private var userAnswer: String = ""
    @State private var userAnswerCorrect: Bool = false
    @State private var showAnswerFeedback: Bool = false
    @State private var questionCount: Int = 0
    
    // Timer state variables
    @State private var timeRemaining: Int = 30 // 30 seconds for the quiz
    @State private var timer: AnyCancellable? // To hold the timer subscription

    var body: some View {
        VStack {
            Text("Time Remaining: \(timeRemaining) seconds")
                .font(.headline)
                .padding()

            if let flashcard = currentFlashcard {
                VStack {
                    Text(flashcard.name)
                        .font(.title)
                        .padding()

                    Text("Translate:")
                        .font(.subheadline)
                        .padding()

                    TextField("Type your answer here...", text: $userAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Text("Example: \(flashcard.exampleSentence)")
                        .padding()

                    Button(action: {
                        answerQuestion()
                    }) {
                        Text("Submit")
                            .frame(minWidth: 100)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            } else {
                // No more flashcards, show quiz summary
                Text("Quiz Complete!")
                    .font(.title)
                    .padding()

                Button(action: {
                    showSummary = true
                }) {
                    Text("View Summary")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .onAppear {
            loadNextFlashcard() // Load the first flashcard when the view appears
            startTimer() // Start the timer
        }
        .onDisappear {
            timer?.cancel() // Cancel the timer if the view disappears
        }
        .alert(isPresented: $showAnswerFeedback) {
            Alert(title: Text(userAnswerCorrect ? "Correct!" : "Incorrect"),
                  message: Text("Your answer was \(userAnswerCorrect ? "correct" : "incorrect")."),
                  dismissButton: .default(Text("Next"), action: {
                      loadNextFlashcard()
                      userAnswer = "" // Clear user input for the next question
                  }))
        }
    }

    private func startTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    // Automatically show summary when time runs out
                    showSummary = true
                    timer?.cancel() // Cancel the timer when it runs out
                }
            }
    }

    private func answerQuestion() {
        if let flashcard = currentFlashcard {
            userAnswerCorrect = userAnswer.lowercased() == flashcard.translation.lowercased()
            if userAnswerCorrect {
                quizScore += 1
            }
            questionCount += 1
            flashcardManager.updateFlashcardPerformance(flashcard: flashcard, isCorrect: userAnswerCorrect)
            showAnswerFeedback = true
        }
    }

    private func loadNextFlashcard() {
        currentFlashcard = flashcardManager.getNextFlashcard()
        if currentFlashcard == nil {
            // If there are no more flashcards, show the summary
            showSummary = true
        }
    }
}

