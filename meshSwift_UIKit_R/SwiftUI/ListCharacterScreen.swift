//
//  ListCharacterScreen.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 21/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import Foundation
import SwiftUI

struct ListCharacterScreen: View {
    
    let list2:[Pg] = [Pg(imgName: "profile", text3:"Helm of the warrior",text4: "Head"),
                      Pg(imgName:"profile", text3:"Headdress of Rags",text4: "Head"),
                      Pg(imgName: "profile", text3:"Name",text4: "Category")
                      ]
    
    init(){
        
        UITableView.appearance().backgroundColor = .init(red: 0.193, green: 0.203, blue: 0.267, alpha: 1)
        
    }
    
    var body: some View {
        
        NavigationView{
                
            List{
            
            ForEach(self.list2,id:\.self){l in
                    
                    NavigationLink(destination:CharacterScreen()){
                        
                        HStack{
                            
                           Image("\(l.imgName)")
                            .resizable()
                            .frame(width:55,height: 55)
                            
                            VStack(alignment:.leading){
                                
                                Text(l.text3).bold()
                                .foregroundColor(.white)
                                
                                Text(l.text4)
                                .foregroundColor(.white)
                                
                            }
                            
                            
                        }
                        
                    }
                    
                }.listRowBackground(Color("Color").scaleEffect(1.2))
                
            }.navigationBarTitle("Characters").foregroundColor(.white)
               
        }.navigationBarBackButtonHidden(true)
            
        }
        
}
            
        
    


struct Pg:Hashable{

    var imgName:String
    
    var img:Image{
        
        Image(imgName)
        
    }
    var text3:String
    var text4:String
    

}



struct ListCharacterScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListCharacterScreen()
    }
}


