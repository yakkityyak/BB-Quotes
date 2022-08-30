//
//  FetchController.swift
//  BB Quotes
//
//  Created by Jakob Hjortshøj on 30/08/2022.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse
    }
    
    private let baseURl = URL(string: "https://www.breakingbadapi.com/api/")!
    
    func fetchQuote() async throws -> Quote {
        let quoteURL = baseURl.appendingPathComponent("quote/random")
        
        let (data, response) = try await URLSession.shared.data(from: quoteURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        return quote
    }
    
    func fetchCharacter(name: String) async throws -> Character {
        let characterURL = baseURl.appendingPathComponent("Characters")
        var characterComponent = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        let characterQueryItem = URLQueryItem(name: "name", value: name)
        characterComponent?.queryItems = [characterQueryItem]
        
        guard let searchURL = characterComponent?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: searchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let character = try JSONDecoder().decode(Character.self, from: data)
        
        return character
    }
}
