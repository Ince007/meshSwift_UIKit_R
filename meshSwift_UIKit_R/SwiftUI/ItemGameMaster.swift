//
//  ItemGameMaster.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 24/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI
//Diminuire logo e label;Allineare tutte le immagini
struct ItemGameMaster: View {
    var body: some View {
        
        NavigationView{
        
        ZStack{
            
            Color("Color").scaleEffect(1.2)
            
            VStack(spacing:45){
                
                HStack(spacing:110){
                    
                    VStack(spacing:20){
                        
                        Image("Characters")
                        
                        Text("Characters").foregroundColor(.white)
                            .font(Font.custom("PT Sans Narrow Bold", size: 25))
                        
                    }
                    
                    VStack(spacing:20){
                        
                        Image("Dice")
                        
                        Text("Dice").foregroundColor(.white).font(Font.custom("PT Sans Narrow Bold", size: 25))
                        
                    }
                    
                }
                
                HStack(spacing:110){
                    
                    VStack(spacing:20){
                        
                        Image("Categories")
                        
                        Text("Categories").foregroundColor(.white).font(Font.custom("PT Sans Narrow Bold", size: 25))
                        
                    }
                    
                    VStack(spacing:20){
                        
                        Image("Items")
                        
                        NavigationLink("Items",destination: ListItem()).foregroundColor(.white).font(Font.custom("PT Sans Narrow Bold", size: 25))
                                            
                    }
                    
                }
                
                HStack(spacing:110){
                    
                    VStack(spacing:20){
                        
                        Image("Trading")
                        
                        Text("Trading").foregroundColor(.white)
                        .font(Font.custom("PT Sans Narrow Bold", size: 25))
                        
                    }
                    
                    NavigationLink(destination:GM_Attributes()){
                        
                        VStack(spacing:20){
                            
                            Image("attributes")
                            
                            Text("Attributes").foregroundColor(.white).font(Font.custom("PT Sans Narrow Bold", size: 25))
                            
                        }
                        
                    }
                    
                    
                    
                }
                
            }
            
        }
        .navigationBarTitle(Text("Game Master"),displayMode: .inline)
        }
            
    }
}

struct ItemGameMaster_Previews: PreviewProvider {
    static var previews: some View {
        ItemGameMaster()
    }
}
