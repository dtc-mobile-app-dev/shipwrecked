//
//  UIOverlay.swift
//  Shipwrecked
//
//  Created by Sam Johanson on 8/2/23.
//

import SwiftUI

struct UIOverlay: View {
    var body: some View {
        HStack(spacing: 500) {
            Image("HealthBar6MAX")
                .resizable()
                .scaledToFit()
//                .frame(width: 200, height: 200)
                .shadow(color: .white, radius: 25)
            
            NavigationLink {
                
                /// Will go to Inventory View like sheet or a popup
                
            } label: {
                Image("OrangeBox")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .shadow(color: .white, radius: 25)
                    .overlay {
                        Image("InventoryIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .shadow(color: .white, radius: 5)

                            .padding(.bottom, 5)
                    }
            }
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
