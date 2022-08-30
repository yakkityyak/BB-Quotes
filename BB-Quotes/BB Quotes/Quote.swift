//
//  Quote.swift
//  BB Quotes
//
//  Created by Jakob Hjortshøj on 30/08/2022.
//

import Foundation

struct Quote: Codable {
    let quote: String
    let auther: String
    let series: String
    
    enum QuoteKeys: String, CodingKey {
        case quote
        case auther
        case series
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let quoteContainer = try container.nestedContainer(keyedBy: QuoteKeys.self)
        
        quote = try quoteContainer.decode(String.self, forKey: .quote)
        auther = try quoteContainer.decode(String.self, forKey: .auther)
        series = try quoteContainer.decode(String.self, forKey: .series)
    }
}
