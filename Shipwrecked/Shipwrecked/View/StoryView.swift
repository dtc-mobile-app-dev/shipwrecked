//
//  StoryView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI

struct StoryView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            HStack {
                Text("Your ship wrecked your ship wrecked your ship wrecked your ship wrecked your ship wrecked your ship wrecked your ship wrecked your ship wrecked your ship wrecked your ship wrecked your ship wrecked big story explaining this or could do an animation?")
//                    .font(CustomFontRetro.body)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView().previewInterfaceOrientation(.landscapeRight)
    }
}
