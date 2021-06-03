//
//  DrawingGroupView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/26/21.
//

import SwiftUI

struct ColorCyclingCircle: View {
    
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
//                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                /*
                 That now renders a gentle gradient, showing bright colors at the top of the circle down to darker colors at the bottom. And now when you run the app you’ll find it runs much slower – SwiftUI is struggling to render 100 gradients as part of 100 separate view
                 */
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct DrawingGroupView: View {
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            Slider(value: $colorCycle)
        }
    }
}

struct DrawingGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGroupView()
    }
}
