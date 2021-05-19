//
//  LargeBlue.swift
//  WeSplit
//
//  Created by Denis Yaremenko on 5/17/21.
//

import SwiftUI

struct LargeBlueText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .background(Color.blue)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
}

