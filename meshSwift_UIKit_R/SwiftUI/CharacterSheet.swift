//
//  CharacterSheet.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 23/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct CharacterSheet: View {
    var body: some View {
        
        ZStack{
            
          Color("Color").scaleEffect(1.2)
            
        
        
            ScrollView{
                
                VStack(spacing:35){
                    
                    ZStack{
                    
                    
                    
                    Image("cornice")
                        .resizable()
                        .frame(width:200,height:150)
                    Image("omino-pg")
                    .resizable()
                    .frame(width:200,height:150)
                        
                    }
                    
                    VStack(spacing:35){
                        
                        VStack(spacing:0.5){
                            
                            HStack{
                                
                                Text("Character Name").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                
                                Text("Player Name").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                                       
                                                       Text("HP").foregroundColor(.white).opacity(0.7)
                                                           .padding()
                                                       
                                                       Spacer()
                                                       
                                                       Text("Grabiel")
                                                       .padding()
                                                       
                                                   }.frame(width:UIScreen.main.bounds.width,height:45)
                                                   .background(Color("Color-6"))
                            
                        }
                        
                        VStack(spacing:0.5){
                            
                            HStack{
                                
                                Text("Birthplace").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:45)
                            .background(Color("Color-6"))
                            
                            HStack{
                                                       
                                                       Text("Birth Date").foregroundColor(.white).opacity(0.7)
                                                           .padding()
                                                       
                                                       Spacer()
                                                       
                                                       Text("Grabiel")
                                                       .padding()
                                                       
                                                   }.frame(width:UIScreen.main.bounds.width,height:45)
                                                   .background(Color("Color-6"))
                            
                        }
                        
                        VStack(spacing:0.5){
                            
                            HStack{
                                
                                Text("Race").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:45)
                            .background(Color("Color-6"))
                            
                            HStack{
                                
                                Text("Sex").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:45)
                            .background(Color("Color-6"))
                            
                            HStack{
                                                       
                                                       Text("Skin").foregroundColor(.white).opacity(0.7)
                                                           .padding()
                                                       
                                                       Spacer()
                                                       
                                                       Text("Grabiel")
                                                       .padding()
                                                       
                                                   }.frame(width:UIScreen.main.bounds.width,height:45)
                                                   .background(Color("Color-6"))
                            
                        }
                        
                        VStack(spacing:0.5){
                            
                            HStack{
                                
                                Text("Age").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                
                                Text("Height").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                
                                Text("Weight").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                
                                Text("Hair").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                
                                Text("Eyes").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                
                                Text("Distinguishing marks").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                
                                Text("Scars").foregroundColor(.white).opacity(0.7)
                                    .padding()
                                
                                Spacer()
                                
                                Text("Grabiel")
                                .padding()
                                
                            }.frame(width:UIScreen.main.bounds.width,height:75)
                            .background(Color("Color-6"))
                            
                            HStack{
                                                       
                                                       Text("Tattoo").foregroundColor(.white).opacity(0.7)
                                                           .padding()
                                                       
                                                       Spacer()
                                                       
                                                       Text("Grabiel")
                                                       .padding()
                                                       
                                                   }.frame(width:UIScreen.main.bounds.width,height:45)
                                                   .background(Color("Color-6"))
                            
                        }
                        
                        HStack{
                            
                            Text("Biography").foregroundColor(.white)
                                .padding()
                            
                            Spacer()
                            
                            Text("Grabiel")
                            .padding()
                            
                        }.frame(width:UIScreen.main.bounds.width,height:45)
                        .background(Color("Color-6"))
                        
                    }
                    
                }
            }
            
        }
        
    }
}

struct CharacterSheet_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSheet()
    }
}
