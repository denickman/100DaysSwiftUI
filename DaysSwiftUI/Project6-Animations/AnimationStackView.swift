//
//  AnimationStackView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/20/21.
//

import SwiftUI

struct AnimationStackView: View {
    
    @State private var enabled = false

    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200, alignment: .center)
        .background(enabled ? Color.blue : Color.red)
        .animation(.default)
//        .animation(nil)
        .foregroundColor(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 50.0 : 0))
        .animation(.interpolatingSpring(stiffness: 5, damping: 5))
    }
}

struct AnimationStackView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationStackView()
    }
}
