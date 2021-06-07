//
//  SizeClassView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/4/21.
//

import SwiftUI

struct SizeClassView: View {
    
    // AnyView, which is what’s called a type erased wrapper
    // AnyView conforms to the same View protocol as Text, Color, VStack, and more, and it also contains inside it a view of a specific type. However, externally AnyView doesn’t expose what it contains – Swift sees our condition as returning either an AnyView or an AnyView, so it’s considered the same type. This is where the name “type erasure” comes from: AnyView effectively hides – or erases – the type of the views it contains.
    
    @Environment(\.horizontalSizeClass) var sizeXXXClass
    
    var body: some View {
        
        // That is, the some View return type of body requires that one single type is returned from all paths in our code – we can’t sometimes return one view and other times return something else
        
        // Hstack and Hstack - not Vstack and Hstack
        
        if sizeXXXClass == .compact {
            return AnyView(HStack {
                Text("Active size class:")
                Text("Compact")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("Regular")
            }
            .font(.largeTitle))
        }
       
    }
}

struct SizeClassView_Previews: PreviewProvider {
    static var previews: some View {
        SizeClassView()
    }
}
