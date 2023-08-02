
//
//  SelectPlayerView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI

struct SelectPlayerView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("select a character to continue")
                        .font(CustomFontBlock.medium)
                        .foregroundColor(.white)
                        .padding(25)
                    
                    ZStack {
                        NavigationLink {
                            StoryView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            HStack {
                                Image("GunnerProfilePic")
                                    .resizable()
                                    .scaledToFill()
                                
                                Image("WelderProfilePic")
                                    .resizable()
                                    .scaledToFill()
                                
                                Image("KevinProfilePic")
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                        .padding()
                        .shadow(color: .white.opacity(0.25), radius: 5)
                    }
                }
            }
        }
    }
}

struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView().previewInterfaceOrientation(.landscapeRight)
    }
}
