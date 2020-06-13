//
//  SelectionColor.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 22/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct SelectionColor: View {
    
    @State private var ColorList = [Color.purple,Color.blue,Color.red,Color.green,Color.yellow]
    @State private var ColorList2 = [Color("Color-3"),Color("Color-7"),Color.gray,Color.orange,Color("Color-8")]
    
    var body: some View {
        
        ZStack{
            
            Color("Color").scaleEffect(1.2)
                    
            ScrollView{
                
                HStack(spacing:30){
                    
                    ForEach(self.ColorList,id:\.self){color in
                        
                        Circle()
                        .fill(color)
                            .frame(width:35,height:35)
                        
                    }
                    
                }
                
                HStack(spacing:30){
                    
                    ForEach(self.ColorList2,id:\.self){color in
                        
                        Circle()
                        .fill(color)
                            .frame(width:35,height:35)
                        
                    }
                    
                }
                
            }
            
        }
              
    }
}

struct provaNav:View{
    
    var body:some View{
        
        Text("Hello world")
        
    }
    
}

struct SelectionColor_Previews: PreviewProvider {
    static var previews: some View {
        SelectionColor()
    }
}
