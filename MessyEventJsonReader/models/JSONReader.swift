//
//  JSONReader.swift
//  MessyEventJsonReader
//
//  Created by Bilolbek Rayimov on 22/10/2026.
//

import Foundation

struct AllEvents {
    let events: [Event?]
}

extension AllEvents: Decodable {
    enum CodingKeys: String, CodingKey {
        case events
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var eventContainer = try container.nestedUnkeyedContainer(forKey: .events)
        
        var tempEvents: [Event?] = []
        while !eventContainer.isAtEnd {
            
            guard try !eventContainer.decodeNil() else {
                
                continue
            }
            
            //do{
                
                let asEvent = try? eventContainer.decode(Event.self)
                
                if let isEvent = asEvent {
                    tempEvents.append(isEvent)
                    continue
                }
                
                let asString = try? eventContainer.decode(String.self)
                
                if asString != nil {
                    continue
                }
                
                let asInt = try? eventContainer.decode(Int.self)
                
                if asInt != nil {
                    continue
                }
                
                print("should not reach this, \(eventContainer.currentIndex)")
            //} catch {
              //  print("errorcha: \(error)")
            //}
        }
        
        self.events = tempEvents
    }
}


func readJSON(_ filename: String) -> AllEvents? {
    if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let jsonData = try decoder.decode(AllEvents.self, from: data)
            return jsonData
        } catch {
            print("error \(error)")
        }
    }
    
    return nil
}
