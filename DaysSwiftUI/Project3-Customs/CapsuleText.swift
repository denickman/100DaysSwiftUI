//
//  CapsuleText.swift
//  WeSplit
//
//  Created by Denis Yaremenko on 5/16/21.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}
