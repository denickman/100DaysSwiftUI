//
//  Watermark.swift
//  WeSplit
//
//  Created by Denis Yaremenko on 5/16/21.
//

import SwiftUI

struct Watermark: ViewModifier {
    
    var text: String
    
    func body(content: Content) -> some View {
        
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
            
        }
    }
}

