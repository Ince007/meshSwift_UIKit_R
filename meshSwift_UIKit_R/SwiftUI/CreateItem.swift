//
//  CreateItem.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 22/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct CreateItem: View {
    
    @State private var prova = ""
    @State private var stepperValue = 1
    @State private var action:Bool = false
    @State private var CategoryName = 0
    
    var categories = ["Not set","Earring","One handed","Two handed","Ranged Weapon","Categories","Enchanted","Weapons"]
    
    var body: some View {
        
        ZStack{
                    
                   Color("Color").scaleEffect(1.2)
                    
            VStack(spacing:90){
                
                VStack(spacing:15){
                            
                            VStack(spacing:0.5){
                                
                                HStack{
                                    
                                    Text("Name").foregroundColor(.white).opacity(0.7)
                                    
                                    TextField("Digita",text: $prova)
                                    
                                }.frame(height:75)
                                .background(Color("Color-6"))
                                
                                Button(action:{
                                    self.action.toggle()
                                }){
                                    
                                    HStack{
                                                       
                                        Text("Category").foregroundColor(.white).opacity(0.7)
                                        
                                        Spacer()
                                                       
                                        Text(self.action == true ? "\(categories[CategoryName])" : "")
                                                       
                                    }.frame(width:UIScreen.main.bounds.width,height:35)
                                    .background(Color("Color-6"))
                                    
                                }
                               
                                HStack{
                                                   
                                    Text("Durability").foregroundColor(.white).opacity(0.7)
                                                   
                                    TextField("Digita",text: $prova)
                                                   
                                }.frame(height:35)
                                .background(Color("Color-6"))
                                
                                HStack{
                                                   
                                    Text("Value").foregroundColor(.white).opacity(0.7)
                                                   
                                    TextField("Digita",text: $prova)
                                                   
                                }.frame(height:35)
                                .background(Color("Color-6"))
                                
                                HStack{

                                    Stepper(value: $stepperValue) {
                                        Text("Quantity: \(stepperValue)").foregroundColor(.white)
                                    }
                                    
                                }.background(Color("Color-6"))
                                
                            }
                            
                            HStack{
                                
                                Text("Description").foregroundColor(.white).opacity(0.7)
                                
                                TextField("Digita",text: $prova)
                                
                            }.frame(height:65)
                            .background(Color("Color-6"))
                            
                                HStack{
                                    
                                    NavigationLink(destination: provaNav()){
                                    
                                    Image("tavolozza")
                                        .resizable()
                                        .frame(width:18,height: 18)
                                        .foregroundColor(.white)
                                        .opacity(0.7)
                                        .padding()
                                                   
                                                       Text("Color").foregroundColor(.white)
                                                        .opacity(0.7)
                                                       
                                                       Spacer()
                                                       
                                                       Circle()
                                                           .fill(Color.gray)
                                                           .frame(width:25,height: 25)
                                        
                                        Image(systemName: "chevron.right")
                                        .resizable()
                                            .frame(width:15,height:25)
                                        .foregroundColor(.white)
                                        .padding()
                                                       
                                                   }
                                                   
                                               }.frame(width:UIScreen.main.bounds.width,height:40)
                                               .background(Color("Color-6"))
                                                 
                        }
                
                Picker(selection: $CategoryName, label: Text("")) {
                    
                    ForEach(0..<categories.count){
                        
                        Text(self.categories[$0])
                            .foregroundColor(.black)
                            .font(Font.system(size: 25))
                            
                    }
                    
                    }
                .labelsHidden()
                .frame(width:UIScreen.main.bounds.width,height: 385)
                .background(Color("Color-9"))
                .offset(y:self.action == true ? 30 : 420)
            
//                .offset(y:self.action == true ? 380 : 100)
                
            }
                    
            }.navigationBarTitle("New category")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action:{}){
                Text("Cancel").foregroundColor(.white)
        })
        
    }
}

struct CreateItem_Previews: PreviewProvider {
    static var previews: some View {
        CreateItem()
    }
}
