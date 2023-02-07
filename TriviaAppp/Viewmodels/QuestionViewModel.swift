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
}

