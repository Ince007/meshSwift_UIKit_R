//
//  CreateCategory.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 28/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct CreateCategory: View {
    
    var categories = ["Head","Hands","Feet","Weapons","Legs","Arms","Chest"]
    @State private var CategoryName = 0
    @State private var action:Bool = false
    @State private var prova = ""
    
    @Environment(\.presentationMode) var presentationMode
    
//     var categoryvalues: CategoryValues
    
        var body: some View {
                    
        ZStack{
            
           Color("Color").scaleEffect(1.2)
            
            VStack(spacing:80){
                
                HStack{

//                    NavigationLink("Cancel",destination: CategoryList()).foregroundColor(.white).padding()

//                    Spacer()

                    Text("New category").foregroundColor(.white)
                        .fontWeight(.bold)
                        .offset(y:-52.5)

//                    Spacer()

//                    NavigationLink("Done",destination: CategoryList()).foregroundColor(.white).padding()

                }.background(Color("Color").scaleEffect(1.2))
                  
                VStack(spacing:0.5){
                    
                    HStack(spacing:50){
                        
                        Text("Name").foregroundColor(.gray).padding()
                        
                        TextField("Digita",text: $prova).foregroundColor(.white)
                        
                    }.frame(width:UIScreen.main.bounds.width,height: 90)
                    .background(Color("Color-1"))
                    
                    Button(action:{
                        self.action.toggle()
                    }){
                        
                        HStack{
                            
                            Text("Equipment slot").foregroundColor(.gray).padding()
                            
                            Spacer()
                            
                            Text(self.action == false ? "" : "\(categories[CategoryName])" ).foregroundColor(.white).padding()
                            
                        }
                        
                    }
                    .frame(width:UIScreen.main.bounds.width,height: 90)
                    .background(Color("Color-1"))
                    
                }
                
                Spacer()
                     
                Picker(selection: $CategoryName, label: Text("")) {
                
                ForEach(0..<categories.count){
                    
                    Text(self.categories[$0]).foregroundColor(.black).font(Font.system(size: 25))
                    
                }
                
                }.labelsHidden()
                .frame(width:UIScreen.main.bounds.width,height: 300)
                .background(Color("Color-9"))
                .offset(y:self.action == false ? 495 : 145)
                
                Spacer()
                
            }
            .padding(.top, 50)
            
            }
//        .navigationBarTitle(Text("New category"), displayMode: .inline).foregroundColor(.red)
//            .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Cancel").foregroundColor(.white)
            }
                ,trailing: Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Done").foregroundColor(.white)
            })
    }
            
    
    
}

struct CreateCategory_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategory()
    }
}
