//
//  AnimationView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/19/21.
//

import SwiftUI

/*
 In SwiftUI, the simplest type of animation is an implicit one: we tell our views ahead of time “if someone wants to animate you, here’s how you should respond”, and nothing more. SwiftUI will then take care of making sure any changes that do occur follow the animation you requested. In practice this makes animation trivial – it literally could not be any easier.
 */

struct AnimationView: View {
    
    @State private var animationAmount: CGFloat = 1.0
    
    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 0.25
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.blue)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(Animation.easeInOut(duration: 2)
                            .repeatForever(autoreverses: false)
                )
        )
        .onAppear(perform: {
            self.animationAmount = 2
        })
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
//        .animation(.default)
//        .animation(.easeOut)
//        .animation(.interpolatingSpring(stiffness: 50, damping: 1))
//        .animation(Animation.easeInOut(duration: 2)
//                    .delay(1))
//        .animation(Animation.easeInOut(duration: 0.5)
//                    .repeatCount(2, autoreverses: true))

    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
