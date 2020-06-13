//
//  List-Session.swift
//  Rhapsody
//
//  Created by Michele Simonetti on 11/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct List_Session: View {
    var body: some View {
            
//          Color("Color").scaleEffect(1.2)
            
            
            
            VStack{
                
                Text("Sessions")
                    .foregroundColor(.white)
                .font(Font.system(size: 30))
                
                HStack{


                        
                        Image("Artboard 1 copy")
                            .resizable()
                            .frame(width:350,height: 80)

                        Image("Artboard 1 copy 2")
                        .resizable()
                        .frame(width:350,height: 80)
                        
                    

                    
                    Image("Artboard 1-1")
                        .resizable()
                        .frame(width:300,height: 80)


                
                
            }
            
            }.background(Color("Color").scaleEffect(1.2))
    }
}

struct List_Session_Previews: PreviewProvider {
    static var previews: some View {
        List_Session()
    }
}
