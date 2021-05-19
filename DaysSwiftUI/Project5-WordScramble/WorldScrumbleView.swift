//
//  WorldScrumbleView.swift
//  100DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/19/21.
//

import SwiftUI

struct WorldScrumbleView: View {
    
    let people = ["Alex", "Victor", "Vasyl", "Roman", "Den"]
    
    var body: some View {
        List {
            Section(header: Text("Section 1")) {
                Text("Static row 1")
                Text("Static row 2")
                Text("Static row 3")
            }
            
            Section(header: Text("Section 2")) {
                ForEach(0..<5){
                    Text("Dynamic row \($0)")
                }
            }
 
            Section(header: Text("Section 3")) {
                Text("Static row 4")
                Text("Static row 5")
                Text("Static row 6")
            }
            
//            Section(header: Text("Section 4")) {
//                List(0..<5) {
//                    Text("Dynamic row \($0)")
//                }
//                .listStyle(GroupedListStyle())
//            }
//
//            Section(header: Text("Section 5")) {
//                List(people, id: \.self) {
//                    Text($0)
//                }
//                .listStyle(GroupedListStyle())
//            }
//
//            Section(header: Text("Section 6")) {
//                List {
//                    ForEach(people, id: \.self) {
//                        Text($0)
//                    }
//                }
//                .listStyle(GroupedListStyle())
//            }
        }
//        .listStyle(GroupedListStyle())
    }
}

struct WorldScrumbleView_Previews: PreviewProvider {
    static var previews: some View {
        WorldScrumbleView()
    }
}
