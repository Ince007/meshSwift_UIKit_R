//
//  prov3.swift
//  Rhapsody
//
//  Created by Michele Simonetti on 08/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct prov3: View {
    
    @State var word = ""
    @State var word2 = ""
    
    var body: some View {
            
            ZStack{

                       Color("Color").scaleEffect(1.2)
            
            VStack(spacing: 25) {
                
                HStack{

                    Text("dfmkldfmb").foregroundColor(Color("Color")).scaleEffect(1.2)

                }
                
                
                HStack(spacing:50){
                    
                        
                        Spacer()
                    
                    
                    Text("New session").font(.title).foregroundColor(.white)
                    
                    NavigationLink(destination:LoginScreen()){
                        
                        Button(action:{
                            print("E funziona cazzo")
                        }){
                            
                            Text("Done").foregroundColor(.white).padding()
                            
                        }
                        
                    }.background(Color.red)
                        
                    
                }
                
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
        
            
        }
        
        .navigationBarBackButtonHidden(true)
        .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
       
        
    }
}

struct prov3_Previews: PreviewProvider {
    static var previews: some View {
        prov3()
    }
}
