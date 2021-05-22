//
//  AnimationGestureView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/20/21.
//

import SwiftUI

struct AnimationGestureView: View {
    
    let letters = Array("Hello SwiftUI")
    
    @State private var enabled = false
    @State private var dragAmountForRectangle = CGSize.zero
    @State private var dragAmountForText = CGSize.zero
    
    var body: some View {
        print("Text: \(dragAmountForText)")
        print("View: \(dragAmountForRectangle)")
        
       return Group {
            HStack(spacing: 0) {
                ForEach(0..<letters.count) {
                    num in
                    Text(String(self.letters[num]))
                        .padding(10)
                        .font(.title)
                        .background(self.enabled ? Color.blue : Color.red)
                        .offset(self.dragAmountForText)
                        .animation(Animation.default.delay(Double(num)/20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({
                        self.dragAmountForText = $0.translation
                    })
                    .onEnded({ _ in
                        self.dragAmountForText = .zero
                        self.enabled.toggle()
                    })
            )
            
            Divider()
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .offset(dragAmountForRectangle) //  we want to use that size to influence the card’s position on-screen
                .gesture(
                    DragGesture()
                        .onChanged {self.dragAmountForRectangle = $0.translation}
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                self.dragAmountForRectangle = .zero
                            }
                        }
                )
        }
    }
}

struct AnimationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationGestureView()
    }
}

