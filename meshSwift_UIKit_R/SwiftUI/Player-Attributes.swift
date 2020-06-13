//
//  Player-Attributes.swift
//  Rhapsody
//
//  Created by Michele Simonetti on 04/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct Player_Attributes: View {
    
    @State private var date = 0
    
    var body: some View {
        
        ZStack{
            
            Color("Color").scaleEffect(1.2)
            
            VStack(spacing:20){
                
                HStack(spacing:65){
                    
                    Text("Attribute Points").foregroundColor(.white).opacity(0.5)
                        .font(Font.system(size: 18)).padding()
                    
                    Spacer()
                    
                    Text("Numero")
                        .foregroundColor(.white).padding()
                    
                
                }
                .frame(width:UIScreen.main.bounds.width,height: 60)
                .background(Color("Color-6"))
                
                VStack(spacing:1){
                    
                    HStack{
                        
                        Text("Strength").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                        
                        Spacer()
                        
                        Stepper("",value: $date)
                        
                    }.frame(width:UIScreen.main.bounds.width,height: 60)
                    .background(Color("Color-6"))
                    
                    HStack{
                        
                        Text("Dexterity").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                        
                        Spacer()
                        
                        Stepper("",value: $date)
                        
                    }.frame(width:UIScreen.main.bounds.width,height: 60)
                    .background(Color("Color-6"))
                    
                    HStack{
                        
                        Text("Intelligence").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                        
                        Spacer()
                        
                        Stepper("",value: $date)
                        
                    }.frame(width:UIScreen.main.bounds.width,height: 60)
                    .background(Color("Color-6"))
                    
                    HStack{
                        
                        Text("Winsdom").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                        
                        Spacer()
                        
                        Stepper("",value: $date)
                        
                    }.frame(width:UIScreen.main.bounds.width,height: 60)
                    .background(Color("Color-6"))
                    
                    HStack{
                        
                        Text("Charisma").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                        
                        Spacer()
                        
                        Stepper("",value: $date)
                        
                    }.frame(width:UIScreen.main.bounds.width,height: 60)
                    .background(Color("Color-6"))
                    
                }
                
            }
            
        }
        
    }
}

struct Player_Attributes_Previews: PreviewProvider {
    static var previews: some View {
        Player_Attributes()
    }
}
