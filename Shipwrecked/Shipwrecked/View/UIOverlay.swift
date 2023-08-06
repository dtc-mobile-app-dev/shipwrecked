//
//  UIOverlay.swift
//  Shipwrecked
//
//  Created by Sam Johanson on 8/2/23.
//

import SwiftUI

struct UIOverlay: View {
    var body: some View {
        HStack(spacing: 550) {
            Image("HealthBar6MAX")
                .scaledToFit()
                .shadow(color: .white, radius: 25)
            
            Image("InventoryIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
                .shadow(color: .white, radius: 25)
        }
        .padding(.bottom, 275)
    }
}

struct UIOverlay_Previews: PreviewProvider {
    static var previews: some View {
        UIOverlay()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
