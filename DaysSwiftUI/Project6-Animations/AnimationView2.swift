//
//  AnimationView2.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/19/21.
//

import SwiftUI

struct AnimationView2: View {
    @State private var animationAmount: CGFloat = 1.0
    
    var body: some View {
        print("AMOUNT: \(animationAmount)")
        
        return VStack {
            Stepper("Scale amount", value:
                        $animationAmount.animation(
                            Animation.easeInOut(duration: 0.25) // every animation
                                .repeatCount(3, autoreverses: true)
                        ), in: 1...3)
                .padding(10)
            Spacer()
            
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct AnimationView2_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView2()
    }
}
