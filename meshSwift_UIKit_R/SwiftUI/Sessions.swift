//
//  Sessions.swift
//  Rhapsody
//
//  Created by Michele Simonetti on 04/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct Sessions: View {
    
    @State var showingSheet:Bool = false
    
    var body: some View {
        
        NavigationView{
        
        ZStack{
            
            if !showingSheet{
                Color("Color").scaleEffect(1.2)
            }
            
            else{
                Color(.gray).scaleEffect(1.2)
            }
            
            
            
            VStack(spacing:30){
                        
                Text("Sessions").foregroundColor(.white).bold().fontWeight(.bold)
                                                            
                VStack(spacing:25){
                    
                    VStack(spacing:15){
                        
                        HStack{
                            
                            NavigationLink("Create a session",destination: prov3()).foregroundColor(.white).padding(.leading)
                            
                            Spacer()
                            
                        }

                        Divider().background(Color.white).opacity(0.2)
                        
                    }
                    
                    VStack(spacing:15){
                        
                        HStack{
                            
                            Button(action : {
                                self.showingSheet.toggle()
                            }){
                                
                                Text("Join a session").foregroundColor(.white)
                                
                            }.padding(.leading)
                            
                            Spacer()
                            
                        }
                        
                        Divider().background(Color.white).opacity(0.2)
                        
                    }
                    
                }
                
                
                        
                       Spacer()
                        
                    }
            
            
            
            if showingSheet{
                
                CreateIdSheet(showingSheet: $showingSheet)
                
            }
            
        }
        
    }
    .navigationBarBackButtonHidden(true)
        .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height - 130)
//        .position(x:210,y:370)
        
    }
}

struct Sessions_Previews: PreviewProvider {
    static var previews: some View {
        Sessions()
    }
}

struct CreateIdSheet:View{
    
    @State private var Num:String = ""
    @Binding var showingSheet:Bool
    
    var body:some View{
        
        VStack(spacing:5){
            
            Text("Join a session").bold()
                .padding(.top)
            
                Text("Enter a id Session")
                
                TextField("",text: $Num).keyboardType(UIKeyboardType.phonePad)
                    .frame(width:140,height:25)
            .cornerRadius(5)
                    .background(Color.white)
            
            Divider()
                
            HStack(spacing:20){
                
                Button(action:{
                    self.showingSheet = false
                }){
                    
                    Text("Cancel").foregroundColor(Color("Foreground-Down")).bold()
                    
                    
                }
                
                Rectangle()
                    .frame(width:0.3,height: 60)
                
                if(!Num.isEmpty){
                    
                    NavigationLink("OK",destination:ListCharacterScreen())
                    
                    Button(action:{
                    }){
                        
                        Text("Ok").foregroundColor(Color("Foreground-Down")).bold()
                        
                    }
                    
                }

            }
            
            
            
        }.frame(width:180,height: 165)
        .background(Color("Background"))
                    .cornerRadius(5)
        
    }
    
}
