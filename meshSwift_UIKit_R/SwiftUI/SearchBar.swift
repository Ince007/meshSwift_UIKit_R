//
//  SearchBar.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 27/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//
import Foundation
import SwiftUI
import UIKit



struct SearchBar: UIViewRepresentable {
    
    @Binding var text:String
    var placeholder:String
    
    class Coordinator:NSObject,UISearchBarDelegate{
        
        @Binding var text:String
        
         init(text:Binding<String>){
            
            _text = text
            
        }
        
        func searchBar(_ searchBar:UISearchBar,textDidChange searchText:String){
            
            text = searchText
            
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        
        let searchBar = UISearchBar(frame:.zero)
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.barTintColor = .red
        searchBar.backgroundColor = .gray
        searchBar.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 10, height: 20)
        searchBar.delegate = context.coordinator
        
        return searchBar
        
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
        uiView.text = text
        
    }
    
}


