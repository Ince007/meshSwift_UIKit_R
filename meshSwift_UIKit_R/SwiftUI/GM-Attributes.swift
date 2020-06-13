//
//  GM-Attributes.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 04/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct GM_Attributes: View {
    
    @State private var firstNum = ""
    @State private var secondNum = ""
    
    var body: some View {
                   
            ZStack{
                
                Color("Color").scaleEffect(1.2)
                
                VStack(spacing:30){
                
               Text("Attributes").foregroundColor(.white).font(Font.system(size: 25))
                    
                    VStack(spacing:15){
                        
                        HStack(spacing:65){
                            
                            Text("Attribute Points").foregroundColor(.white).opacity(0.5)
                                .font(Font.system(size: 18))
                            
                            Rectangle()
                                .foregroundColor(.white).opacity(0.5)
                                .frame(width:0.3,height:60)
                            
                            TextField("",text: $firstNum).keyboardType(UIKeyboardType.phonePad)
                                .foregroundColor(.white)
                            
                        
                        }
                        .frame(width:UIScreen.main.bounds.width,height: 60)
                        .background(Color("Color-6"))
                        
                        HStack(spacing:65){
                            
                            Text("Max Attribute Value").foregroundColor(.white).opacity(0.5)
                                .font(Font.system(size: 15.5))
                            
                            Rectangle()
                                .foregroundColor(.white).opacity(0.5)
                                .frame(width:0.3,height:60)
                            
                            TextField("",text: $secondNum).keyboardType(UIKeyboardType.phonePad)
                                .foregroundColor(.white)
                            
                        
                        }
                        .frame(width:UIScreen.main.bounds.width,height: 60)
                        .background(Color("Color-6"))
                        
                    }
                    
                    VStack(spacing:1){
                        
                        HStack{
                            
                            Text("Strength").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                            
                            Spacer()
                            
                        }.frame(width:UIScreen.main.bounds.width,height: 60)
                        .background(Color("Color-6"))
                        
                        HStack{
                            
                            Text("Dexterity").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                            
                            Spacer()
                            
                        }.frame(width:UIScreen.main.bounds.width,height: 60)
                        .background(Color("Color-6"))
                        
                        HStack{
                            
                            Text("Intelligence").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                            
                            Spacer()
                            
                        }.frame(width:UIScreen.main.bounds.width,height: 60)
                        .background(Color("Color-6"))
                        
                        HStack{
                            
                            Text("Winsdom").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                            
                            Spacer()
                            
                        }.frame(width:UIScreen.main.bounds.width,height: 60)
                        .background(Color("Color-6"))
                        
                        HStack{
                            
                            Text("Charisma").foregroundColor(.white).opacity(0.5).font(Font.system(size: 25)).padding()
                            
                            Spacer()
                            
                        }.frame(width:UIScreen.main.bounds.width,height: 60)
                        .background(Color("Color-6"))
                        
                    }
                        
                    Spacer()
                    
        }
                
                
                
                
                
            }
            
            
        
        
    }
}

struct GM_Attributes_Previews: PreviewProvider {
    static var previews: some View {
        GM_Attributes()
    }
}
