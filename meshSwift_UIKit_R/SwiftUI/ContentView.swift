//
//  ContentView.swift
//  disegni
//
//  Created by Michele Simonetti on 16/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI
struct ContentView: View {
    
    var body: some View {
        
        NavigationView{
        
            VStack(spacing:40){
            
            Text("Hi.Welcolme to the tool for D&D-like games.With this app you can be a very cool Game master.You can press a button to see the first aspect of this tool in development.")
            
            HStack{
                
                NavigationLink(destination:LoginScreen()){
                    Text("Press to login")
                }
                
                NavigationLink(destination:EquipScreen()){
                    Text("Press to watch an equipment")
                }
                
                NavigationLink(destination:ItemScreen()){
                    Text("Press to watch a list of items")
                }
                
                NavigationLink(destination:CharacterScreen()){
                    Text("Press to read statistics")
                }
                
                NavigationLink(destination:SessionList()){
                    Text("Press to visit a session")
                }
                
            }
            
        }
            
        }
        
            }
            
        }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct equip:View{
//
//    var body:some View{
//
//
//
//    }
//
//}

struct highview:View{
    
    @State var index = 0
    
    var body:some View{
        
        ZStack{
            
            HStack(spacing:60){
                Button(action: {
                    
                    self.index = 0
                    
                }) {
                    Text("Armour").foregroundColor(self.index == 0 ? .white : .black)
                }
                
                Button(action: {
                    
                    self.index = 1
                    
                }) {
                    Text("Objects").foregroundColor(self.index == 1 ? .white : .black)
                }

                
                
            }.position(x: 200, y: 60)
            
            Path{path in
                
                path.move(to: CGPoint(x:112,y:80))
                path.addLine(to: CGPoint(x:168,y:80))
                
            }.trimmedPath(from: 0, to: 1)
                       .strokedPath(StrokeStyle(lineWidth:1,lineCap: .round,lineJoin: .round))
                .foregroundColor(self.index == 0 ? .white : .black)
            
            Path{path in
                
                path.move(to: CGPoint(x:231,y:80))
                path.addLine(to: CGPoint(x:287,y:80))
                
            }.trimmedPath(from: 0, to: 1)
                       .strokedPath(StrokeStyle(lineWidth:1,lineCap: .round,lineJoin: .round))
                .foregroundColor(self.index == 1 ? .white : .black)
            
//            Hexagon
            Path{path in
                
                path.move(to: CGPoint(x:100,y:130))
                path.addLine(to: CGPoint(x:150,y:180))
                path.addLine(to: CGPoint(x:150,y:230))
                path.addLine(to: CGPoint(x:100,y:280))
                path.addLine(to: CGPoint(x:50,y:230))
                path.addLine(to: CGPoint(x:50,y:180))
                path.addLine(to: CGPoint(x:100,y:130))
                
            }.trimmedPath(from: 0, to: 1)
                   .strokedPath(StrokeStyle(lineWidth:8,lineCap: .round,lineJoin: .round))
                .foregroundColor(.white)
            
        }
        
        
        
        
        
    }
    
}

struct disegni:View{
    
    var body:some View{
        
        ZStack{
              
              Color("Color").scaleEffect(1.2)
                  
                      Path{path in
                          
                          path.move(to: CGPoint(x:20,y:195))
                          path.addLine(to: CGPoint(x:50,y:145))
                          path.addLine(to: CGPoint(x:95,y:145))
                          path.addLine(to: CGPoint(x:125,y:195))
                          path.addLine(to: CGPoint(x:95,y:235))
                          path.addLine(to: CGPoint(x:50,y:235))
                          path.addLine(to: CGPoint(x:20,y:195))
                          
                          
                      }.trimmedPath(from: 0, to: 1)
                                     .strokedPath(StrokeStyle(lineWidth:8,lineCap: .round,lineJoin: .round))
                          .foregroundColor(Color("Color2"))
              
              Path{path in
                  
                  path.move(to: CGPoint(x:20,y:335))
                  path.addLine(to: CGPoint(x:50,y:285))
                  path.addLine(to: CGPoint(x:95,y:285))
                  path.addLine(to: CGPoint(x:125,y:335))
                  path.addLine(to: CGPoint(x:95,y:375))
                  path.addLine(to: CGPoint(x:50,y:375))
                  path.addLine(to: CGPoint(x:20,y:335))
                  
                  
              }.trimmedPath(from: 0, to: 1)
                             .strokedPath(StrokeStyle(lineWidth:8,lineCap: .round,lineJoin: .round))
                  .foregroundColor(Color("Color2"))
                      
                      Path{path in
                          
                          path.move(to: CGPoint(x:30,y:195))
                          path.addLine(to: CGPoint(x:60,y:155))
                          path.addLine(to: CGPoint(x:85,y:155))
                          path.addLine(to: CGPoint(x:115,y:195))
                          path.addLine(to: CGPoint(x:85,y:225))
                          path.addLine(to: CGPoint(x:60,y:225))
                          path.addLine(to: CGPoint(x:30,y:195))
                          
                          
                      }.trimmedPath(from: 0, to: 1)
                                     .strokedPath(StrokeStyle(lineWidth:5,lineCap: .round,lineJoin: .round))
                          .foregroundColor(Color("Color2"))
              
              Path{path in
                  
                  path.move(to: CGPoint(x:30,y:335))
                  path.addLine(to: CGPoint(x:60,y:295))
                  path.addLine(to: CGPoint(x:85,y:295))
                  path.addLine(to: CGPoint(x:115,y:335))
                  path.addLine(to: CGPoint(x:85,y:365))
                  path.addLine(to: CGPoint(x:60,y:365))
                  path.addLine(to: CGPoint(x:30,y:335))
                  
                  
              }.trimmedPath(from: 0, to: 1)
                             .strokedPath(StrokeStyle(lineWidth:5,lineCap: .round,lineJoin: .round))
                  .foregroundColor(Color("Color2"))
        
                              Path{path in
                  
                                  path.move(to: CGPoint(x:150,y:195))
                                  path.addLine(to: CGPoint(x:130,y:145))
                                  path.addLine(to: CGPoint(x:330,y:145))
                                  path.addLine(to: CGPoint(x:350,y:195))
                                  path.addLine(to: CGPoint(x:330,y:235))
                                  path.addLine(to: CGPoint(x:130,y:235))
                                  path.addLine(to: CGPoint(x:150,y:195))
                  
                              }.trimmedPath(from: 0, to: 1)
                                  .strokedPath(StrokeStyle(lineWidth:4,lineCap: .round,lineJoin: .round))
                                  .foregroundColor(.white)
              
              Path{path in
              
                              path.move(to: CGPoint(x:150,y:335))
                              path.addLine(to: CGPoint(x:130,y:285))
                              path.addLine(to: CGPoint(x:330,y:285))
                              path.addLine(to: CGPoint(x:350,y:335))
                              path.addLine(to: CGPoint(x:330,y:375))
                              path.addLine(to: CGPoint(x:130,y:375))
                              path.addLine(to: CGPoint(x:150,y:335))
              
                          }.trimmedPath(from: 0, to: 1)
                              .strokedPath(StrokeStyle(lineWidth:4,lineCap: .round,lineJoin: .round))
                              .foregroundColor(.white)
              
              Path{path in
                  
                  path.move(to: CGPoint(x:305,y:60))
                  path.addLine(to: CGPoint(x:330,y:30))
                  path.addLine(to: CGPoint(x:355,y:30))
                  path.addLine(to: CGPoint(x:380,y:60))
                  path.addLine(to: CGPoint(x:355,y:90))
                  path.addLine(to: CGPoint(x:330,y:90))
                  path.addLine(to: CGPoint(x:305,y:60))
                  
                  
              }.trimmedPath(from: 0, to: 1)
                             .strokedPath(StrokeStyle(lineWidth:5,lineCap: .round,lineJoin: .round))
                  .foregroundColor(.white)
              
              Path{path in
                  
                  path.move(to: CGPoint(x:315,y:60))
                  path.addLine(to: CGPoint(x:335,y:40))
                  path.addLine(to: CGPoint(x:350,y:40))
                  path.addLine(to: CGPoint(x:370,y:60))
                  path.addLine(to: CGPoint(x:350,y:80))
                  path.addLine(to: CGPoint(x:330,y:80))
                  path.addLine(to: CGPoint(x:315,y:60))
                  
                  
              }.trimmedPath(from: 0, to: 1)
                             .strokedPath(StrokeStyle(lineWidth:2,lineCap: .round,lineJoin: .round))
                  .foregroundColor(.white)
              
              
                  
                  }
        
    }
    
}

