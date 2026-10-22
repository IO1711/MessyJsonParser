//
//  DaysLeftView.swift
//  MessyEventJsonReader
//
//  Created by Bilolbek Rayimov on 22/10/2026.
//

import SwiftUI

struct DaysLeftView: View {
    
    let days: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.daysLeftBg)
                .frame(width: 80)
            
            VStack {
                Text(String(days))
                    .font(.title2)
                Text("days")
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    DaysLeftView(days: "12")
}
