//
//  Event.swift
//  MessyEventJsonReader
//
//  Created by Bilolbek Rayimov on 22/10/2026.
//

import Foundation

struct Event: Identifiable {
    let id: String?
    let title: String?
    let start: String?
    let end: String?
    let duration: String?
    let location: Location?
    let attendees: [Attendee?]?
    var identifier: String { id ?? UUID().uuidString }
}

extension Event: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, title, start, end, duration, location, attendees
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var asString = try? container.decodeIfPresent(String.self, forKey: .start)
        var asDouble = try? container.decodeIfPresent(Double.self, forKey: .start)
        
        if asString == nil, let isDouble = asDouble {
            
            let date = Date(timeIntervalSince1970: isDouble)
            let readableDate = date.formatted(date: .long, time: .omitted)
            
            self.start = readableDate
        } else if let issString = asString {
            
            if let date = try? Date(issString, strategy: .iso8601) {
                self.start = date.formatted(date: .long, time: .omitted)
            } else if let timestampAsString = Double(issString) {
                let date = Date(timeIntervalSince1970: timestampAsString)
                let readableDate = date.formatted(date: .long, time: .omitted)
                
                self.start = readableDate
            } else {
                self.start = nil
            }
            
        } else {
            
            self.start = nil
        }
        
        self.end = try container.decodeIfPresent(String.self, forKey: .end)
        
        asString = try? container.decodeIfPresent(String.self, forKey: .duration)
        asDouble = try? container.decodeIfPresent(Double.self, forKey: .duration)
        var asInt = try? container.decodeIfPresent(Int.self, forKey: .duration)
        
        if asString == nil, let isInt = asInt {
            self.duration = String(isInt)
        } else if asString == nil, let isDouble = asDouble {
            self.duration = String(isDouble)
        } else {
            self.duration = asString
        }
        
        
        asString = try? container.decodeIfPresent(String.self, forKey: .location)
        let asLocation = try? container.decodeIfPresent(Location.self, forKey: .location)
        
        if asLocation == nil, let isString = asString {
            self.location = Location(name: isString, room: nil, geo: nil)
        } else {
            self.location = asLocation
        }
        
        asString = try? container.decodeIfPresent(String.self, forKey: .attendees)
        let asArray = try? container.decodeIfPresent([Attendee?].self, forKey: .attendees)
        
        if let isString = asString {
            self.attendees = [
                Attendee(name: nil, email: isString)
            ]
        } else if asArray != nil {
            var attendeeContainer = try container.nestedUnkeyedContainer(forKey: .attendees)
            var tempAttendees: [Attendee?] = []
            while !attendeeContainer.isAtEnd {
                var tempAttendee: Attendee? = nil
                
                asString = try? attendeeContainer.decode(String.self)
                
                if let isString = asString {
                    tempAttendee = Attendee(name: nil, email: isString)
                    continue
                }
                
                let asAttendee = try? attendeeContainer.decode(Attendee.self)
                
                if let isAttendee = asAttendee {
                    tempAttendee = isAttendee
                    continue
                }
                
                asInt = try? attendeeContainer.decode(Int.self)
                
                tempAttendees.append(tempAttendee)
                
            }
            
            self.attendees = tempAttendees
            
        } else {
            self.attendees = nil
        }
    }
}
