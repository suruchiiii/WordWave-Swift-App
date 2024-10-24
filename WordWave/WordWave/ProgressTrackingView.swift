//
//   ProgressTrackingView.swift
//  WordWave
//
//  Created by RPS on 19/10/24.
//

import SwiftUI

struct ProgressTrackingView: View {
    @State private var progress = ProgressModel(totalFlashcards: 20, masteredFlashcards: 15, quizScores: [80, 90, 100, 70, 85])
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Progress Tracking")
                    .font(.largeTitle)
                    .padding()
                
                // Retention Rate
                Text("Retention Rate: \(String(format: "%.2f", progress.retentionRate))%")
                    .font(.headline)

                // Average Score
                Text("Average Quiz Score: \(String(format: "%.2f", progress.averageScore))")
                    .font(.headline)

                // Quiz Performance Bars
                VStack(spacing: 5) {
                    ForEach(progress.quizScores.indices, id: \.self) { index in
                        HStack {
                            Text("Session \(index + 1): \(progress.quizScores[index])")
                            Spacer()
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: CGFloat(progress.quizScores[index]), height: 20) // Bar length based on score
                        }
                    }
                }
                .padding()

                Spacer()
            }
            .navigationTitle("User Progress")
            .padding()
        }
    }
}

