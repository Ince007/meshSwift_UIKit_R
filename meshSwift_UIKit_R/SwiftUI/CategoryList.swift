//
//  CategoryList.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 25/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct CategoryList: View {
    
    let categories:[category] = [
    
        category(text: "One Hands", text2: "Weapons"),
        category(text: "Two Hands", text2: "Weapons"),
        category(text: "Chain mail", text2: "Chest"),
        category(text: "Plated armor", text2: "Chest"),
        category(text: "Name", text2: "Slot"),
        category(text: "Name", text2: "Slot"),
        category(text: "Name", text2: "Slot"),
        category(text: "Name", text2: "Slot"),
        category(text: "Name", text2: "Slot"),
        category(text: "Name", text2: "Slot"),
        category(text: "Name", text2: "Slot"),
        category(text: "Name", text2: "Slot"),
    
    ]
    
    @State private var searchText = ""
   
    var body: some View {
        
        VStack(spacing:1){
            
            HStack{
                
                Spacer()
                
                Text("Categories").bold().foregroundColor(.white)
                
                Spacer()
                
                NavigationLink(destination:CreateCategory()){
                    
                   Image(systemName:"plus").foregroundColor(.white).padding()
                    
                }
                
                
                
            }.frame(width:UIScreen.main.bounds.width,height: 40)
            .background(Color("Color").scaleEffect(1.2))
                
                SearchBar(text:$searchText,placeholder:"Search category")
                    .padding()
                
                List{
                    
                    ForEach(self.categories.filter{self.searchText.isEmpty ? true : $0.text.lowercased().contains(self.searchText)},id:\.self){cat in
                        
                      HStack{
                            
                        
                        
                        VStack(alignment:.leading){
                            
                            Text(cat.text).bold()
                                .foregroundColor(.white)
                            Text(cat.text2).foregroundColor(.white).opacity(0.5)
                            
                        }
                            
                       }
                        
                    }.listRowBackground(Color("Color").scaleEffect(1.2))

                }
                
        }.background(Color("Color").scaleEffect(1.2))

    }
}

struct category:Hashable {
    
    var text:String
    var text2:String
    
}

    





struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}
