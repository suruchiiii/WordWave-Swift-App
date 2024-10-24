//
//  ContentView.swift
//  WordWave
//
//  Created by RPS on 19/10/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject var flashcardManager = FlashcardManager()
    @State private var showQuizSummary = false
    @State private var quizScore: Int = 0
    @State private var totalQuestions: Int = 0

    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(flashcardManager.flashcards) { flashcard in
                        VStack(alignment: .leading) {
                            Text(flashcard.name)
                                .font(.headline)
                            Text("Translation: \(flashcard.translation)")
                            Text("Example: \(flashcard.exampleSentence)")
                        }
                    }
                    .onDelete(perform: deleteFlashcards)
                }
                .navigationTitle("Flashcards")
                .toolbar {
                    NavigationLink(destination: CreateFlashcardView(flashcardManager: flashcardManager)) {
                        Text("Add")
                    }
                }
            }
            .tabItem {
                Label("Flashcards", systemImage: "book.fill")
            }

            NavigationView {
                QuizView(flashcardManager: flashcardManager, quizScore: $quizScore, showSummary: $showQuizSummary)
                    .onAppear {
                        totalQuestions = flashcardManager.flashcards.count
                    }
                    .fullScreenCover(isPresented: $showQuizSummary) {
                        QuizSummaryView(score: quizScore, totalQuestions: totalQuestions, resetQuizAction: {
                            resetQuiz()
                        })
                    }
            }
            .tabItem {
                Label("Quiz", systemImage: "questionmark.circle.fill")
            }

            ProgressTrackingView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar")
                }
        }
    }

    private func deleteFlashcards(at offsets: IndexSet) {
        flashcardManager.flashcards.remove(atOffsets: offsets)
        flashcardManager.saveFlashcards()
    }

    private func resetQuiz() {
        quizScore = 0 // Reset the score
        flashcardManager.resetQuiz() // Reset the quiz in the manager
        flashcardManager.loadFlashcards() // Optionally reload flashcards if necessary
    }
}
#Preview {
    ContentView()
}
