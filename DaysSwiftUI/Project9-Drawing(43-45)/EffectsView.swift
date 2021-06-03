//
//  EffectsView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/26/21.
//

import SwiftUI

struct EffectsView: View {
    
    @State private var amount: CGFloat = 0.0
    
    var body: some View {
//        ZStack {
//            Image("example")
//
//            Rectangle()
//                .fill(Color.white)
//                .blendMode(.multiply)
//        }
//        .frame(width: 400, height: 500)
//        .clipped()
        
        // the same as previous
//        Image("example")
//            .colorMultiply(.blue)
        
        VStack {
        
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                // screen = it inverts the colors, performs a multiply, then inverts them again, resulting in a brighter image rather than a darker image

                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
        
            
//            Image("example")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 200, height: 200)
//                .saturation(Double(amount))
//                .blur(radius: (1 - amount) * 20)
            
// // saturation - adjusts how much color is used inside a view. Give this a value between 0 (no color, just grayscale) and 1 (full color).
//            Slider(value: $amount)
//                .padding()
        }
        
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
    }
}

struct EffectsView_Previews: PreviewProvider {
    static var previews: some View {
        EffectsView()
    }
}
