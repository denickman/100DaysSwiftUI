//
//  DrawingView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/25/21.
//

import SwiftUI

struct Triangle: Shape {
    /*
     The key to understanding the difference between Path and Shape is reusability: paths are designed to do one specific thing, whereas shapes have the flexibility of drawing space and can also accept parameters to let us customize them further.
     */

    // required method
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint.init(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint.init(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint.init(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint.init(x: rect.midX, y: rect.minY))
        
        return path
    }
}


struct Arc: InsettableShape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifierStart = startAngle - rotationAdjustment
        let modifierEnd = endAngle - rotationAdjustment
 
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifierStart, endAngle: modifierEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct DrawingView: View {
    var body: some View {
        
        
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 10)
        
        VStack {

            Triangle()
//                .fill(Color.red)
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)
            
            Circle()
//                .stroke(Color.blue, lineWidth: 40)
                .strokeBorder(Color.blue, lineWidth: 40)
            
            
            Arc(startAngle: .degrees(0),
                endAngle: .degrees(110),
                clockwise: true)
                .stroke(Color.orange, lineWidth: 10)
                .frame(width: 200, height: 200)
            
            Path { path in
                path.move(to: CGPoint(x: 200, y: 100))
                
                path.addLine(to: CGPoint(x: 100, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300)) // for smoothing top corner
            }
    //        .fill(Color.blue)
    //        .stroke(Color.blue.opacity(0.25), lineWidth: 12)
            .stroke(Color.blue,
                    style:
                        StrokeStyle(lineWidth: 10,
                                    lineCap: .butt,
                                    lineJoin: .bevel))
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
