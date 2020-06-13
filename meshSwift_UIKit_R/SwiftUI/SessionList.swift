//
//  SessionList.swift
//  disegni
//
//  Created by Michele Simonetti on 20/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct SessionList: View {
    var body: some View {
//        ZStack{
//
//              Color("Color").scaleEffect(1.2)
//
//            Image(systemName: "plus")
//            .resizable()
//                .frame(width:25,height: 25)
//                .foregroundColor(.white)
//                .position(x:343,y:60)
//
//                      Path{path in
//
//                          path.move(to: CGPoint(x:20,y:195))
//                          path.addLine(to: CGPoint(x:50,y:145))
//                          path.addLine(to: CGPoint(x:95,y:145))
//                          path.addLine(to: CGPoint(x:125,y:195))
//                          path.addLine(to: CGPoint(x:95,y:235))
//                          path.addLine(to: CGPoint(x:50,y:235))
//                          path.addLine(to: CGPoint(x:20,y:195))
//
//
//                      }.trimmedPath(from: 0, to: 1)
//                                     .strokedPath(StrokeStyle(lineWidth:8,lineCap: .round,lineJoin: .round))
//                          .foregroundColor(Color("Color2"))
//
//              Path{path in
//
//                  path.move(to: CGPoint(x:20,y:335))
//                  path.addLine(to: CGPoint(x:50,y:285))
//                  path.addLine(to: CGPoint(x:95,y:285))
//                  path.addLine(to: CGPoint(x:125,y:335))
//                  path.addLine(to: CGPoint(x:95,y:375))
//                  path.addLine(to: CGPoint(x:50,y:375))
//                  path.addLine(to: CGPoint(x:20,y:335))
//
//
//              }.trimmedPath(from: 0, to: 1)
//                             .strokedPath(StrokeStyle(lineWidth:8,lineCap: .round,lineJoin: .round))
//                  .foregroundColor(Color("Color2"))
//
//                      Path{path in
//
//                          path.move(to: CGPoint(x:30,y:195))
//                          path.addLine(to: CGPoint(x:60,y:155))
//                          path.addLine(to: CGPoint(x:85,y:155))
//                          path.addLine(to: CGPoint(x:115,y:195))
//                          path.addLine(to: CGPoint(x:85,y:225))
//                          path.addLine(to: CGPoint(x:60,y:225))
//                          path.addLine(to: CGPoint(x:30,y:195))
//
//
//                      }.trimmedPath(from: 0, to: 1)
//                                     .strokedPath(StrokeStyle(lineWidth:5,lineCap: .round,lineJoin: .round))
//                          .foregroundColor(Color("Color2"))
//
//              Path{path in
//
//                  path.move(to: CGPoint(x:30,y:335))
//                  path.addLine(to: CGPoint(x:60,y:295))
//                  path.addLine(to: CGPoint(x:85,y:295))
//                  path.addLine(to: CGPoint(x:115,y:335))
//                  path.addLine(to: CGPoint(x:85,y:365))
//                  path.addLine(to: CGPoint(x:60,y:365))
//                  path.addLine(to: CGPoint(x:30,y:335))
//
//
//              }.trimmedPath(from: 0, to: 1)
//                             .strokedPath(StrokeStyle(lineWidth:5,lineCap: .round,lineJoin: .round))
//                  .foregroundColor(Color("Color2"))
//
//                              Path{path in
//
//                                  path.move(to: CGPoint(x:150,y:195))
//                                  path.addLine(to: CGPoint(x:130,y:145))
//                                  path.addLine(to: CGPoint(x:330,y:145))
//                                  path.addLine(to: CGPoint(x:350,y:195))
//                                  path.addLine(to: CGPoint(x:330,y:235))
//                                  path.addLine(to: CGPoint(x:130,y:235))
//                                  path.addLine(to: CGPoint(x:150,y:195))
//
//                              }.trimmedPath(from: 0, to: 1)
//                                  .strokedPath(StrokeStyle(lineWidth:4,lineCap: .round,lineJoin: .round))
//                                  .foregroundColor(.white)
//
//              Path{path in
//
//                              path.move(to: CGPoint(x:150,y:335))
//                              path.addLine(to: CGPoint(x:130,y:285))
//                              path.addLine(to: CGPoint(x:330,y:285))
//                              path.addLine(to: CGPoint(x:350,y:335))
//                              path.addLine(to: CGPoint(x:330,y:375))
//                              path.addLine(to: CGPoint(x:130,y:375))
//                              path.addLine(to: CGPoint(x:150,y:335))
//
//                          }.trimmedPath(from: 0, to: 1)
//                              .strokedPath(StrokeStyle(lineWidth:4,lineCap: .round,lineJoin: .round))
//                              .foregroundColor(.white)
//
//              Path{path in
//
//                  path.move(to: CGPoint(x:305,y:60))
//                  path.addLine(to: CGPoint(x:330,y:30))
//                  path.addLine(to: CGPoint(x:355,y:30))
//                  path.addLine(to: CGPoint(x:380,y:60))
//                  path.addLine(to: CGPoint(x:355,y:90))
//                  path.addLine(to: CGPoint(x:330,y:90))
//                  path.addLine(to: CGPoint(x:305,y:60))
//
//
//              }.trimmedPath(from: 0, to: 1)
//                             .strokedPath(StrokeStyle(lineWidth:5,lineCap: .round,lineJoin: .round))
//                  .foregroundColor(.white)
//
//              Path{path in
//
//                  path.move(to: CGPoint(x:315,y:60))
//                  path.addLine(to: CGPoint(x:335,y:40))
//                  path.addLine(to: CGPoint(x:350,y:40))
//                  path.addLine(to: CGPoint(x:370,y:60))
//                  path.addLine(to: CGPoint(x:350,y:80))
//                  path.addLine(to: CGPoint(x:330,y:80))
//                  path.addLine(to: CGPoint(x:315,y:60))
//
//
//              }.trimmedPath(from: 0, to: 1)
//                             .strokedPath(StrokeStyle(lineWidth:2,lineCap: .round,lineJoin: .round))
//                  .foregroundColor(.white)
//
//
//
//                  }
        
        
//        ZStack{

//            Color("Color").scaleEffect(1.2)

        VStack{
            
            HStack{
                
                Text("Sessions")
                    .bold()
                    .position(x:200,y:20)
                    .foregroundColor(.white)
                    .font(Font.system(size: 30))
                    
                
                NavigationLink(destination:Sessions()){
                     
                     Image(systemName: "plus")
                     .resizable()
                         .frame(width:30,height: 30)
                         .foregroundColor(.white)
                        .position(x:50,y:20)
                
                }
                .frame(width:40,height: 40)
                .position(x:130,y:20)
                 
            }

             HStack{

                 ZStack{

                     Image("Artboard 1 copy")
                         .resizable()
                         .frame(width:365,height: 90)

                     Image("Artboard 1 copy 2")
                     .resizable()
                     .frame(width:365,height: 90)

                 }.position(x:225,y:10)
                 Image("Artboard 1-1")
                     .resizable()
                     .frame(width:315,height: 90)
                     .position(x:5,y:10)


             }

             NavigationLink(destination:CategoryList()){

                 VStack(alignment:.leading){

                    Text("D & D").foregroundColor(.white).font(Font.system(size: 15)).bold()
                     Text("March of the Castle").foregroundColor(.white).font(Font.system(size: 15))
                     Text("57834756483").foregroundColor(.white).font(Font.system(size: 15))

                 }
//                 .position(x:250,y:-140)

             }
            .position(x:250,y:-138)



            VStack(alignment:.leading){

                Text("D & D 2").foregroundColor(.white).font(Font.system(size: 15)).fontWeight(.bold)
                 Text("March of the Castle 2").foregroundColor(.white).font(Font.system(size: 15))
                 Text("57834756483").foregroundColor(.white).font(Font.system(size: 15))

             }.position(x:260,y:-153)

             HStack{

                 ZStack{

                     Image("Artboard 1 copy")
                         .resizable()
                         .frame(width:365,height: 90)

                     Image("Artboard 1 copy 2")
                     .resizable()
                     .frame(width:365,height: 90)

                 }.position(x:225,y:-300)
                 Image("Artboard 1-1")
                     .resizable()
                     .frame(width:315,height: 90)
                     .position(x:5,y:-300)

             }
             
             
            
        }
    .navigationBarBackButtonHidden(true)
        .background(Color("Color").scaleEffect(1.2))
        .position(x:210,y:335)

//            }

    }
    
}

struct SessionList_Previews: PreviewProvider {
    static var previews: some View {
        SessionList()
    }
}
