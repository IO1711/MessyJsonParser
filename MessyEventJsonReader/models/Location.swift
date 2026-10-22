//
//  Location.swift
//  MessyEventJsonReader
//
//  Created by Bilolbek Rayimov on 22/10/2026.
//

import Foundation

struct Location {
    let name: String?
    let room: String?
    let geo: Geo?
}


extension Location: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, room, geo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.room = try container.decodeIfPresent(String.self, forKey: .room)
        
        self.geo = try container.decodeIfPresent(Geo.self, forKey: .geo)
    }
}
