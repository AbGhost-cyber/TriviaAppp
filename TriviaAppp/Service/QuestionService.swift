//
//  QuestionService.swift
//  TriviaAppp
//
//  Created by dremobaba on 2023/2/6.
//

import Foundation

protocol QuestionAPI {
    func fetchQuestion(category: String) async throws -> [Question]
}

enum ApiError: Error {
    case invalidURL
    case invalidResponseType
    case httpStatusCodeFailed(statusCode: Int, error: Error?)
}

struct QuestionAPiImpl: QuestionAPI {
    private let session = URLSession.shared
    private let baseURL = URL(string: "https://the-trivia-api.com/api/")
    private let jsonDecoder = JSONDecoder()
    
    
    func fetchQuestion(category: String) async throws -> [Question] {
        guard let url = URL(string: "questions?limit=10&categories=\(category)", relativeTo: baseURL) else { throw ApiError.invalidURL }
        let(data, _): ([Question], Int) = try await fetch(url: url)
         return data
    }
    
    
    private func fetch<D: Decodable>(url: URL) async throws -> (D, Int) {
        let (data, response) = try await session.data(from: url)
        let statusCode = try validateHTTPResponse(response: response)
        return (try jsonDecoder.decode(D.self, from: data), statusCode)
    }
    
    
    private func validateHTTPResponse(response: URLResponse) throws -> Int {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponseType
        }
        guard 200...299 ~= httpResponse.statusCode ||
                400...499 ~= httpResponse.statusCode else {
            throw ApiError.httpStatusCodeFailed(statusCode: httpResponse.statusCode, error: nil)
        }
        return httpResponse.statusCode
    }
}
