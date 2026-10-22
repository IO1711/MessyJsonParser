//
//  Attendee.swift
//  MessyEventJsonReader
//
//  Created by Bilolbek Rayimov on 22/10/2026.
//

import Foundation

struct Attendee {
    let name: String?
    let email: String?
}

extension Attendee: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
    }
}
