//
//  ItemScreen.swift
//  disegni
//
//  Created by Michele Simonetti on 20/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import Foundation
import SwiftUI
//Cambiare dimensioni
struct ItemScreen: View {
    
    let lista:[oggetti] = [oggetti.init(text:"Helm of the warrior",text2: "Head",color: Color("Color-2")),oggetti.init(text:"Headdress of Rags",text2: "Head",color: Color("Color-2")),oggetti.init(text:"Name",text2: "Category",color: Color("Color-3")),oggetti.init(text:"Name",text2: "Category",color: Color("Color-3")),oggetti.init(text:"Name",text2: "Category",color: Color("Color-2"))]
    
    @State private var searchTerm:String = ""
    
    var body: some View {

        
        List(
            
            lista,
            id:\.text,
            rowContent:{obj in
                HStack {
                            Capsule()
                                .fill(obj.color)
                            .frame(width: 20, height: 40)
                    VStack(alignment:.leading){
                        Text(obj.text).bold()
                        Text(obj.text2)
                    }
                }
            }
            
        )

        }
        
    }


struct oggetti{
    
    var text:String
    var text2:String
    var color:Color
    
}

struct ItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        ItemScreen()
    }
}

//struct SearchBar:UIViewRepresentable{
//
//    @Binding var text:String
//    
//    class Coordinator:NSObject,UISearchBarDelegate{
//
//        @Binding var text:String
//        
//        init(text: Binding<String>){
//
//            _text = text
//
//        }
//        
//         func searchBar(_ searchBar:UISearchBar,textDidChange searchText:String){
//                
//                text = searchText
//                
//            }
//
//    }
//    
//   
//
//    func makeCoordinator() -> SearchBar.Coordinator {
//        return Coordinator(text:$text)
//    }
//    
//    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar{
//        let searchBar = UISearchBar(frame: .zero)
//        searchBar.delegate = context.coordinator
//        return searchBar
//    }
//    
//    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
//        uiView.text = text
//    }
//    
//}
