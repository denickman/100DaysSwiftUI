//
//  BordersView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/26/21.
//

import SwiftUI

struct BordersView: View {
    var body: some View {
        
        VStack(spacing: 20) {
            Rectangle()
                .strokeBorder(ImagePaint(image: Image("example"), scale: 0.2), lineWidth: 10)
                .frame(width: 300, height: 200)
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("example"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 200)
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 300)
                //            .background(Color.red)
                //            .border(Color.red, width: 30)
                //            .background(Image("example"))
                //            .border(ImagePaint(image: Image("example"), scale: 0.2), width: 30)
                .border(ImagePaint(image: Image("example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
        }
    }
}

struct BordersView_Previews: PreviewProvider {
    static var previews: some View {
        BordersView()
    }
}
