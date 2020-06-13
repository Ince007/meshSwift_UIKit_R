//
//  CharacterScreen.swift
//  disegni
//
//  Created by Michele Simonetti on 20/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct CharacterScreen: View {
    var body: some View {
        
        ZStack{
            
            Color("Color").scaleEffect(1.2)
                    
            VStack(spacing:70){
                
                VStack(spacing:30){
                    
                   Text("Character").foregroundColor(.white).bold().font(Font.system(size: 30))
                    
                    ZStack{
                        
                        Image("cornice")
                            .resizable()
                            .frame(width:180,height:135)
                        Image("omino-pg")
                        .resizable()
                        .frame(width:180,height:135)
                        
                    }
                    
                }
                
                
                
                VStack(spacing:55){
                    
                    
                    
                    
                    
                    VStack{
                        
                        Text("Rayne").foregroundColor(.white).font(Font.system(size: 25))
                        Text("HP 15/15").foregroundColor(.white).font(Font.system(size: 25))
                        
                    }
                    
                    VStack(spacing:15){
                        
                        Rectangle()
                        .fill(Color.white)
                        .frame(width:300,height: 1)
                        
                        HStack(spacing:110){

                            VStack(spacing:20){
                                
                                Image("Sheet")
                                .resizable()
                                .frame(width:75,height: 75)
                                
                                NavigationLink("Sheet",destination: CharacterSheet()).foregroundColor(.white)
                                                                
                            }
                            
                            VStack(spacing:20){
                                
                                Image("backpack")
                                    .resizable()
                                    .frame(width:60,height: 60)
                                
                                NavigationLink("Backpack",destination: BackpackScreen()).foregroundColor(.white)
                                                                
                            }
                            
                        }
                        
                        HStack(spacing:110){
                            
                            VStack(spacing:20){
                                
                                Image("attributes")
                                .resizable()
                                .frame(width:85,height: 85)
                                Text("Attributes").foregroundColor(.white)
                                
                            }
                            
                            VStack(spacing:20){
                                
                                Image("equipment")
                                .resizable()
                                .frame(width:75,height: 75)
                                
                                NavigationLink("Equipment",destination: EquipScreen()).foregroundColor(.white)
                                                                
                            }
                            
                        }
                        
                        HStack(spacing:110){
                            
                            VStack(spacing:20){
                                
                                Image("trade")
                                .resizable()
                                .frame(width:75,height: 75)
                                Text("Trade").foregroundColor(.white)
                                
                            }
                            
                            VStack(spacing:20){
                                
                                Image("dice")
                                .resizable()
                                .frame(width:75,height: 75)
                                Text("Dice").foregroundColor(.white)
                                
                            }
                            
                        }
                    }
                    
                }
                
                
                
                
            }
            
        }.navigationBarBackButtonHidden(true)
        
        
        
    }
}

struct CharacterScreen_Previews: PreviewProvider {
    static var previews: some View {
        CharacterScreen()
    }
}
