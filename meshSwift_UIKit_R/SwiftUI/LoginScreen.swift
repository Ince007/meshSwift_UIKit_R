//
//  LoginScreen.swift
//  disegni
//
//  Created by Michele Simonetti on 19/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

//Result == 1 Passare alla pagina successiva passando i dati
//result == -2 Non effettuare transizione

import SwiftUI

struct LoginScreen: View {
    
    @State private var email = ""
    @State private var pass = ""
    
    var body: some View {
        
        NavigationView{
        
        ZStack{
            
            Color("Color").scaleEffect(1.2)
            
            VStack(spacing:75){

                Image("rhapsody_logo_login_screen")
                    .resizable()
                    .frame(width:290,height: 265)
                
                VStack(spacing:10){
                    
                    HStack {
                        Image("omino-1")
                        .resizable()
                            .frame(width:25,height: 25)
                            .position(x:55,y:45)
                        
                        if email.isEmpty{
                            
                            Text("Email").font(Font.custom("PT Display Regular", size: 15))
                                           .foregroundColor(.white)
                            
                        }
                        
                            TextField("", text: $email)
                                .foregroundColor(.white)
                            .frame(width:250,height: 60)
                        .font(Font.custom("PT Display Regular", size: 15))
                             
                    }
                        .background(Color("Color").scaleEffect(1.2))
                    
                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.gray, lineWidth: 1)
                    .frame(width:355,height: 55)
                        
                    ) .padding()
                    
                    HStack {
                        Image("lucchetto-1")
                        .resizable()
                            .frame(width:25,height: 25)
                        .position(x:55,y:45)
                        
                        
                        if pass.isEmpty{
                            
                            Text("Password")
                            .font(Font.custom("PT Display Regular", size: 15))
                            .foregroundColor(.white)
                            
                        }
                        
                            TextField("", text: $pass)
                                .font(Font.custom("PT Display Regular", size: 15))
                                .foregroundColor(.white)
                            .frame(width:230,height: 60)
                             
                    }
                        .background(Color("Color").scaleEffect(1.2))
                    
                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.gray, lineWidth: 1)
                    .frame(width:355,height: 55)
                        
                    ) .padding()
                    
                    
                    
                    
                    NavigationLink(destination: Text("SessionPageSwift")){
                    
                    Button(action:{
                        var i = 0
                        var inventorySocketManager = InventorySocketManager(serverIp: "37.116.236.3", serverPort: 8181, typeProtocol: .tcp,autostart: true)
                        inventorySocketManager.connect(username: self.email, password: self.pass, connectionInstance: inventorySocketManager, completion: { result in
                        
                        if(i == 0)
                        {
                            if result == "-2"{
                                
                                print("Password or email wrong!")
                                
                            }
                            
                            print("\nRisposta iniziale = \(result)\n")
                        }
                        else if(i == 1)
                            
                        {
                            print("\nNumero Sessioni = \(result)\n")
                        }
                            
                        
                        else
                        {
                            var sockRes = inventorySocketManager.retriveSocketResponseType(data: result)
                            print("Tipo:\(sockRes.Type) Message:\(sockRes.Message)")
                        }
                        i = i + 1
                        })
                    }){
                        
                        Text("Login").foregroundColor(.white)

                        
                        
                    }.frame(width:200,height: 55)
                    .background(Color("Color-11"))
                    .cornerRadius(.infinity)
                    
 
                    }
                       
                    
                    
                    
                    
                    HStack{
                        
                        Spacer()
                        
                        NavigationLink("Setting",destination:Setting())
                            
                        .foregroundColor(.white)
                        
                    }.padding()
                    
                }
                    
            }
            
        }
        
        }
//        .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
}
    
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
