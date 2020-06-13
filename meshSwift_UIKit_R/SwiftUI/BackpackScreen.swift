//
//  BackpackScreen.swift
//  Rhapsody
//
//  Created by Michele Simonetti on 12/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct BackpackScreen: View {
    
    let objects:[Objectino] = [
        
        Objectino(NameObject: "Helm of the warrior", category: "Head", color: Color("Color-2"), qta: "1"),
        Objectino(NameObject: "Helm of the warrior", category: "Head", color: Color("Color-2"), qta: "1"),
        Objectino(NameObject: "Helm of the warrior", category: "Head", color: Color("Color-3"), qta: "Quantity"),
        Objectino(NameObject: "Helm of the warrior", category: "Head", color: Color("Color-3"), qta: "Quantity"),
        Objectino(NameObject: "Helm of the warrior", category: "Head", color: Color("Color-4"), qta: "Quantity"),
        Objectino(NameObject: "Helm of the warrior", category: "Head", color: Color("Color-5"), qta: "Quantity"),
        Objectino(NameObject: "Helm of the warrior", category: "Head", color: Color("Color-5"), qta: "Quantity"),
        
    ]
    
    @State private var searchText = ""
    @State var switching:Bool = true
    @State var switching2:Bool = false
    
    var body: some View {
        
        VStack(spacing:10){
            
            HStack{
                
                Spacer()
                
                Text("Item").foregroundColor(.white).font(.title)
                
                Spacer()
                
                
                
            }.background(Color("Color").scaleEffect(1.2))
            
            SearchBar(text:$searchText,placeholder:"")
                .background(Color("Color").scaleEffect(1.2))
            
            
            
            HStack(spacing:50){
            
                    Button(action:{
                    self.switching = false
                    self.switching2 = true
                },label:{ Text("Item received").foregroundColor(self.switching == true ? Color(.black) : Color(.white)) })
                    .background(self.switching == true ? Color(.gray) : Color("Color")).scaleEffect(1.2)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(self.switching == true ? Color.gray : Color.white, lineWidth: 2)
                        .frame(width:120,height: 20)
                
                )
                
                Button(action:{
                    self.switching2 = false
                    self.switching = true
                               },label:{ Text("Your item").foregroundColor(self.switching2 == true ? Color(.black) : Color(.white)) })
                                   .background(self.switching2 == true ? Color(.gray) : Color("Color")).scaleEffect(1.2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(self.switching2 == true ? Color.gray : Color.white, lineWidth: 2)
                            .frame(width:100,height: 20)
                    
                    )

            }.frame(width:UIScreen.main.bounds.width,height: 60)
            .background(Color("Color").scaleEffect(1.2))
            
            List{

                ForEach(self.objects.filter{self.searchText.isEmpty ? true : $0.NameObject.lowercased().contains(self.searchText)},id:\.self){objs in

                    HStack{

                        Capsule()
                            .fill(objs.color)
                            .frame(width:20,height: 45)

                        VStack(alignment:.leading){

                            Text(objs.NameObject).bold().foregroundColor(.white)
                            Text(objs.category).foregroundColor(.white).opacity(0.5)

                        }

                        Spacer()

                        Text(objs.qta).foregroundColor(.white).opacity(0.5)

                    }

                }.listRowBackground(Color("Color").scaleEffect(1.2))

            }
            
        }
        
    }
}




struct Objectino:Hashable{
    
    
    var NameObject:String
    var category:String
    var color:Color
    var qta:String
    
}

struct BackpackScreen_Previews: PreviewProvider {
    static var previews: some View {
        BackpackScreen()
    }
}
