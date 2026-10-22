//
//  PinShapeView.swift
//  MessyEventJsonReader
//
//  Created by Bilolbek Rayimov on 22/10/2026.
//

import SwiftUI

struct PinShapeView: View {
    var body: some View {
        VStack(spacing: 0) { // Crucial: eliminates gap between circle and line
            Circle()
                .fill(Color.black)
                .frame(width: 10, height: 10)
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 1, height: 100) // Controls thickness and height
        }
    }
}


#Preview {
    PinShapeView()
}
