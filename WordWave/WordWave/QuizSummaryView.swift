//
//   QuizSummaryView.swift
//  WordWave
//
//  Created by RPS on 21/10/24.
//

import SwiftUI

struct QuizSummaryView: View {
    let score: Int
    let totalQuestions: Int
    let resetQuizAction: () -> Void
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
    @State private var showProgress = false // State to toggle progress view

    var body: some View {
        VStack(spacing: 20) {
            Text("Quiz Complete!")
                .font(.largeTitle)
                .padding()

            Text("Score: \(score) out of \(totalQuestions)")
                .font(.title)

            HStack {
                Button(action: {
                    resetQuizAction() // Reset the quiz
                    presentationMode.wrappedValue.dismiss() // Dismiss summary view
                }) {
                    Text("Restart Quiz")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    showProgress.toggle() // Toggle to show progress view
                }) {
                    Text("View Progress")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .sheet(isPresented: $showProgress) {
            ProgressTrackingView() // Present the progress view
        }
    }
}
