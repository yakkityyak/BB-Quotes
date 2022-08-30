//
//  Character.swift
//  BB Quotes
//
//  Created by Jakob Hjortshøj on 30/08/2022.
//

import Foundation

struct Character: Codable {
    let name: String
    let birthday: String
    let occupation: [String]
    let image: URL
    let nickname: String
    let portrayedBy: String
    
    enum CharacterKeys: String, CodingKey {
        case name
        case birthday
        case occupation
        case image = "img"
        case nickname
        case portrayedBy = "portrayed"
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let characterContainer = try container.nestedContainer(keyedBy: CharacterKeys.self)
        
        name = try characterContainer.decode(String.self, forKey: .name)
        birthday = try characterContainer.decode(String.self, forKey: .birthday)
        occupation = try characterContainer.decode([String].self, forKey: .occupation)
        image = try characterContainer.decode(URL.self, forKey: .image)
        nickname = try characterContainer.decode(String.self, forKey: .nickname)
        portrayedBy = try characterContainer.decode(String.self, forKey: .portrayedBy)
    }
}
