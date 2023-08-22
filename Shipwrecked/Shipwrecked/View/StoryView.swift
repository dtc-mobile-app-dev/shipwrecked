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
            Color.white.edgesIgnoringSafeArea(.all)
            ConstantsView.backgroundColorOne.edgesIgnoringSafeArea(.all)
            
            NavigationLink {
                LoadingView().navigationBarBackButtonHidden(true)
            } label: {
                ConstantsView.storyTitle
                    .font(CustomFontBlock.body).foregroundColor(.black).shadow(color: .white, radius: 5).padding(.leading, 75).padding(.trailing, 75)
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView().previewInterfaceOrientation(.landscapeRight)
    }
}
