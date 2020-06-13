//
//  CreateSession.swift
//  Rhapsody
//
//  Created by Michele Simonetti on 07/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct CreateSession: View {
    
    @State var word = ""
    @State var word2 = ""
    
    var body: some View {
            
            NavigationView{
                
                ZStack{
            
            Color("Color").scaleEffect(1.2)
            
           
                
            VStack{
                
                VStack{
                    
                    HStack{
                        
                        Text("Title")
                            .font(Font.custom("pt-sans-narrow-web-bold", size: 20)).foregroundColor(Color("Color-10"))
                            .padding(.leading)
                        
                        Spacer()
                        
                    }
                    
                    TextField("", text: $word).foregroundColor(.white).padding(.leading)
                    
                    Divider().background(Color.white).opacity(0.2)
                    
                }
                
                VStack{
                    
                    HStack{
                        
                        Text("Subtitle") .font(Font.custom("pt-sans-narrow-web-bold", size: 20)).foregroundColor(Color("Color-10")).padding(.leading)
                        
                        Spacer()
                        
                    }
                    
                    TextField("", text: $word2).foregroundColor(.white).padding(.leading)
                    
                    Divider().background(Color.white).opacity(0.2)
                    
                }
                
                Spacer()
                
            }
              
                .font(.title)
                .padding(.top, 25)
                
            .navigationBarTitle("New session",displayMode: .inline)
                
            .navigationBarItems(
                leading: Button(action:{}){
                    Text("Cancel")
                    
                },
                trailing: Button(action:{}){
                    Text("Done")
                }
                
                )
                
            }
            
        }
    }
}

struct CreateSession_Previews: PreviewProvider {
    static var previews: some View {
        CreateSession()
    }
}
