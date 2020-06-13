//
//  Setting.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 04/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct Setting: View {
    var body: some View {
        
        ZStack{
            
            Color("Color").scaleEffect(1.2)
            
            VStack(spacing:40){
                
                Text("Setting").foregroundColor(.white)
                
                VStack(alignment:.leading,spacing:30){
                    
                    Text("Log out").foregroundColor(.white)
                    
                    Divider()
                    
                    Text("Change Email").foregroundColor(.white)
                    
                    Divider()
                    
                    Text("Change Password").foregroundColor(.white)
                    
                }
                
                Spacer()
                
            }
            
        }
        
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
