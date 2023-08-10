
//
//  SelectPlayerView.swift
//  Shipwrecked
//
//  Created by Lillian Cain on 8/1/23.
//

import SwiftUI

struct SelectPlayerView: View {
    
    @StateObject var scene = GameScene()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("select a character to continue")
                    .font(CustomFont8Bit.medium)
                    .foregroundColor(.white)
                    .padding(.bottom, 275)
            }
            
            
            //                            NavigationLink {
            //                                StoryView(scene: scene).navigationBarBackButtonHidden(true)
            //                            } label: {
            //                                Button(action: {
            //                                    scene.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
            //                                }, label: {
            //
            //                                })
            //                                Image("GunnerProfilePic")
            //                                    .scaledToFit()
            //                            }
            //                            .onTapGesture {
            //                                scene.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
            //                            }
            //
            //                            NavigationLink {
            //                                StoryView(scene: scene).navigationBarBackButtonHidden(true)
            //                            } label: {
            //                                Image("WelderProfilePic")
            //                                    .scaledToFit()
            //                            }
            //
            //                            NavigationLink {
            //                                StoryView(scene: scene).navigationBarBackButtonHidden(true)
            //                            } label: {
            //                                Image("KevinProfilePic")
            //                                    .scaledToFit()
            //                            }
            
            
            
            //                        NavigationLink(destination: StoryView(scene: scene).navigationBarBackButtonHidden(true)) {
            //                            HStack {
            //                                Button(action: {
            //
            //                                    scene.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
            //                                }, label: {
            //                                    Image("GunnerProfilePic")
            //                                        .scaledToFit()
            //
            //                                })
            //
            //                                Button(action: {
            //                                    scene.currentPlayer = Player(character: "WelderRight1", weapon: "welder", heathPoints: 10)
            //                                }, label: {
            //                                    Image("WelderProfilePic")
            //                                        .scaledToFit()
            //
            //                                })
            //
            //                                Button(action: {
            //                                    scene.currentPlayer = Player(character: "KevinRight1", weapon: "Kevin", heathPoints: 10)
            //                                }, label: {
            //                                    Image("KevinProfilePic")
            //                                        .scaledToFit()
            //                                })
            //                            }
            //                        }
            
            //                    ZStack {
            
            
            NavigationLink {
                StoryView(scene: scene).navigationBarBackButtonHidden(true)
            } label: {
                HStack {
                    Image("GunnerProfilePic").scaledToFit()
                    
                    Button {
                        scene.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
                        
                    } label: {
                        Image("GunnerProfilePic")
                            .resizable()
                            .scaledToFill()
                    }
                    
                    
                    Button {
                        scene.currentPlayer = Player(character: "WelderRight1", weapon: "welder", heathPoints: 10)
                    } label: {
                        Image("WelderProfilePic")
                            .resizable()
                            .scaledToFill()
                    }
                    
                    Button {
                        scene.currentPlayer = Player(character: "KevinRight1", weapon: "kevin", heathPoints: 10)
                    } label: {
                        Image("KevinProfilePic")
                            .resizable()
                            .scaledToFill()
                        
                    }
                }
            }
        }
    }
    //        //                    .padding()
    //        .shadow(color: .white.opacity(0.25), radius: 2.5)
    //
    //
}

//    var ImagesOfCharacters: some View {
//        HStack {
//            Button(action: {
//                scene.currentPlayer = Player(character: "GunnerRight1", weapon: "gunner", heathPoints: 10)
//            }, label: {
//                Image("GunnerProfilePic")
//                    .scaledToFit()
//            })
//
//            Button(action: {
//                scene.currentPlayer = Player(character: "WelderRight1", weapon: "welder", heathPoints: 10)
//            }, label: {
//                Image("WelderProfilePic")
//                    .scaledToFit()
//            })
//
////            Button(action: {
////                scene.currentPlayer = Player(character: "KevinRight1", weapon: "Kevin", heathPoints: 10)
////            }, label: {
//                Image("KevinProfilePic")
//                    .scaledToFit()
//                    .onTapGesture {
//                        scene.currentPlayer = Player(character: "KevinRight1", weapon: "Kevin", heathPoints: 10)
//                    }
////            })
//        }
//    }


struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView().previewInterfaceOrientation(.landscapeRight)
    }
}
