
//
//  SelectPlayerView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI

struct SelectPlayerView: View {
    
    @State var characterIsSelected = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Select a character to continue")
//                        .font(CustomFontRetro.medium)
                        .foregroundColor(.white)
                        .padding(25)
                    
                    ZStack {
                        HStack {
                            NavigationLink(value: characterIsSelected) {
                                
                                Button(action: {
                                    self.characterIsSelected = true
                                }, label: {
                                    Image("Gunner")
                                        .resizable()
                                        .scaledToFill()
                                })
                            }
                            
                            Button(action: {
                                characterIsSelected.toggle()
                            }, label: {
                                Image("Welder")
                                    .resizable()
                                    .scaledToFill()
                            })
                            
                            Button(action: {
                                characterIsSelected.toggle()
                            }, label: {
                                Image("Welder")
                                    .resizable()
                                    .scaledToFill()
                            })
                        }
                        .padding()
                        .shadow(color: .white.opacity(0.25), radius: 5)
                    }
                }
            }
        }
        
        if characterIsSelected {
            StoryView()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}

struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView().previewInterfaceOrientation(.landscapeRight)
    }
}
