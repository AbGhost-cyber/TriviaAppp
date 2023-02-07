//
//  QuestionViewModel.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/7.
//

import Foundation

@MainActor
class QuestionViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    
    @Published var userScores: [Score] = []
    @Published var currentScore: Score = Score()
    
    let service: QuestionAPI
    
    @Published var isLoading: Bool = false
    @Published var errorText: String = ""
    
    init (service: QuestionAPI = QuestionAPiImpl()) {
        self.service = service
    }
    
    func fetchQuestions(category: String) async throws {
        self.isLoading = true
        do {
            let data = try await service.fetchQuestion(category: category)
            self.questions = data
            self.isLoading = false
        } catch {
            errorText = error.localizedDescription
        }
    }
    
   private func upsertScore(score: Score) {
        if let scorePosition = userScores.firstIndex(where: {$0.question == score.question}) {
            userScores[scorePosition] = score
        } else {
            userScores.append(score)
        }
    }
    func updateCurrentScore(_ score: Score) {
        self.currentScore.userOption = score.userOption
        self.currentScore.isCorrect = score.isCorrect
        self.currentScore.question = score.question
        upsertScore(score: score)
    }
    func playAgain(category: String) async throws {
        userScores.removeAll()
        currentScore = Score()
        questions.removeAll()
        try await fetchQuestions(category: category)
    }
    func getUserScore() -> Int {
        return self.userScores.filter({$0.isCorrect == true }).count
    }
}

