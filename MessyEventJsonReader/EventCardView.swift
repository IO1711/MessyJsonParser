//
//  EventCardView.swift
//  MessyEventJsonReader
//
//  Created by Bilolbek Rayimov on 22/10/2026.
//

import SwiftUI

struct EventCardView: View {
    
    let event: Event?
    
    var body: some View {
        HStack {
            PinShapeView()
                .padding(20)
            
            VStack(alignment: .leading){
                Text(event?.title ?? "Unknown")
                    .font(.title2)
                Text("Start date: \(event?.start ?? "No data")")
                    .font(.caption)
                
                Spacer()
                Text("Where: \(event?.location?.name ?? ""), \(event?.location?.room ?? "")")
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            VStack {
                Spacer()
                DaysLeftView(days: event?.duration ?? "99")
            }
            .padding(10)
        }
        .frame(width: 350, height: 150)
        .background(.cardBg, in: RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    EventCardView(
        event: Event(id: "ww", title: "Best event", start: "today", end: "no idea", duration: "77", location: Location(name: "Best hotel", room: "102", geo: nil), attendees: nil)
    )
}
