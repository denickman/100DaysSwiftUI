//
//  AnimationView3.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/19/21.
//

import SwiftUI

struct AnimationView3: View {
    
    @State private var animationRedButtonAmount = 0.0
    @State private var animationOrangeButtonAmount = 0.0
 
    var body: some View {
        
        Group {
            Button("Tap Me") {
                withAnimation {
                    self.animationRedButtonAmount += 360
                }
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(animationRedButtonAmount),
                axis: (x: 1.0, y: 0.0, z: 0.0))
            
            Divider()
    
            Button(action: {
                withAnimation(.interpolatingSpring(stiffness: 3, damping: 5)) {
                    self.animationOrangeButtonAmount += 360
                }
            }, label: { Text("Touch Me\n Again")
                .multilineTextAlignment(.center)
                .font(.headline)
            })
            .padding(50)
            .background(Color.orange)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .rotation3DEffect(
                .degrees(animationOrangeButtonAmount),
                axis: (x: 1.0, y: 0.0, z: 0.0))
        }
        .padding(20.0)
    }
}

struct AnimationView3_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView3()
    }
}
