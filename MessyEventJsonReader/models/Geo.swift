//
//  Geo.swift
//  MessyEventJsonReader
//
//  Created by Bilolbek Rayimov on 22/10/2026.
//

import Foundation

struct Geo {
    let lat: Double?
    let lng: Double?
}

extension Geo: Decodable {
    enum CodingKeys: String, CodingKey {
        case lat, lng
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var asDouble = try? container.decodeIfPresent(Double.self, forKey: .lat)
        var asString = try? container.decodeIfPresent(String.self, forKey: .lat)
        
        if asDouble == nil, let isString = asString {
            self.lat = Double(isString)
        } else {
            self.lat = asDouble
        }
        
        asDouble = try? container.decodeIfPresent(Double.self, forKey: .lng)
        asString = try? container.decodeIfPresent(String.self, forKey: .lng)
        
        if asDouble == nil, let isString = asString {
            self.lng = Double(isString)
        } else {
            self.lng = asDouble
        }
        
        
    }
}
