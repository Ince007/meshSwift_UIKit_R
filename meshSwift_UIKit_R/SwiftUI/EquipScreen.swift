//
//  EquipScreen.swift
//  disegni
//
//  Created by Michele Simonetti on 20/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI
//Cambiare font,aumentare dimensioni parole
struct EquipScreen: View {
    var body: some View {
                ZStack{
        
                    Color("Color").scaleEffect(1.2)
        
                    VStack(spacing:40){
                        
                        Text("Equipment:Body")
                        .foregroundColor(.white)
                        .font(Font.custom("PT Sans Narrow", size: 25))
                        .fontWeight(.bold)
                           
                        
                        VStack(spacing:20){
                            HStack(spacing:65){
                                VStack(spacing:20){
                                    Image("elmo_icon")
                                        .resizable()
                                        .frame(width:137,height: 127)
                
                                    Text("Head").foregroundColor(.white)
                                        .font(Font.custom("PT Sans Narrow", size: 27.5))
                                        .fontWeight(.regular)
                                }
                
                                VStack(spacing:20){
                                    Image("chest")
                                    .resizable()
                                        .frame(width:137,height: 127)
                                    Text("Chest").foregroundColor(.white)
                                        .font(Font.custom("PT Sans Narrow", size: 27.5))
                                    .fontWeight(.regular)
                                }
                            }
                        }
                        
                        HStack(spacing:65){
                                        VStack(spacing:20){
                                            Image("arms")
                                                .resizable()
                                                .frame(width:137,height: 127)
                        
                                            Text("Arms").foregroundColor(.white)
                                                .font(Font.custom("PT Sans Narrow", size: 27.5))
                                                .fontWeight(.regular)
                                        }
                        
                                        VStack(spacing:20){
                                            Image("legs")
                                            .resizable()
                                                .frame(width:137,height: 127)
                                            Text("Legs").foregroundColor(.white)
                                                .font(Font.custom("PT Sans Narrow", size: 27.5))
                                            .fontWeight(.regular)
                                        }
                                    }
                        
                        HStack(spacing:65){
                                        VStack(spacing:20){
                                            Image("hands")
                                                .resizable()
                                                .frame(width:137,height: 127)
                        
                                            Text("Hands").foregroundColor(.white)
                                                .font(Font.custom("PT Sans Narrow", size: 27.5))
                                                .fontWeight(.regular)
                                        }
                        
                                        VStack(spacing:20){
                                            Image("feet")
                                            .resizable()
                                                .frame(width:137,height: 127)
                                            Text("Feet").foregroundColor(.white)
                                                .font(Font.custom("PT Sans Narrow", size: 27.5))
                                            .fontWeight(.regular)
                                        }
                                    }
                        
                    }
        
                }
    }
}

struct EquipScreen_Previews: PreviewProvider {
    static var previews: some View {
        EquipScreen()
    }
}
