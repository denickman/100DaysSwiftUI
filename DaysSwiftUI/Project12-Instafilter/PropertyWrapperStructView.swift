//
//  PropertyWrapperStructView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/5/21.
//

import SwiftUI

struct PropertyWrapperStructView: View {
    
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.yellow
    @State private var titleText = ""
    
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        
        let blur = Binding<CGFloat>(
            // Binding - captures the information needed to update the view when the binding value changes
            
            // It’s also a requirement that we don’t store it as a property of our view, because reading one property from another isn’t allowed
                   get: {
                       self.blurAmount
                   },
                   set: {
                       self.blurAmount = $0
                       print("New value is \(self.blurAmount)")
                   }
               )
        
       return VStack {
            Text(titleText)
                .blur(radius: blurAmount)
                .frame(width: 300, height: 300, alignment: .center)
                .background(backgroundColor)
                .onTapGesture {
                    self.showingActionSheet = true
                }
                .actionSheet(isPresented: $showingActionSheet, content: {
                    
                    ActionSheet(title: Text("Change background"),
                                message: Text("Select a new color"),
                                buttons: [
                                    .default(Text("Red")) {
                                        self.backgroundColor = .red
                                        self.titleText = "Red Color"
                                    },
                                    .default(Text("Green")) {
                                        self.backgroundColor = .green
                                        self.titleText = "Green Color"
                                    },
                                    .default(Text("Blue")) {
                                        self.backgroundColor = .blue
                                        self.titleText = "Blue Color"
                                    },
                                    .cancel()
                    ])
                })
            
            Slider(value: blur, in: 0...20)
        }
    }
}

struct PropertyWrapperStructView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyWrapperStructView()
    }
}
