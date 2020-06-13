//
//  prov.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 02/06/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import SwiftUI

struct prov: View {
      
    init() {
        UITableView.appearance().backgroundColor = .green // Uses UIColor
    }
      
    var body: some View {
        NavigationView {
            List {
                ForEach(1...3, id: \.self) { index in
                    NavigationLink( destination: DetailView()) {
                        ContentCell()
                    }
                    .frame(height: 100)
                    .listRowBackground(Color.blue) // Uses Color
                }
            }
            .navigationBarTitle("My List")
              
        }
        //.background(Color.green)// Not working
    }
}
  
struct ContentCell: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("An item to display.")
            }
            .frame(width: (geometry.size.width), height: geometry.size.height, alignment: .center)
            .background(Color.red)// Working
        }
    }
}
  
struct DetailView: View {
    var body: some View {
        VStack {
            Text ("At the detail view")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.green)// Working
        .edgesIgnoringSafeArea(.all)
    }
}
