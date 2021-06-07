//
//  BindingView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/4/21.
//

import SwiftUI

struct PushButton: View {
    let title: String
    
    @Binding var isOn: Bool
    // this is where @Binding comes in: it allows us to create a two-way connection between PushButton and whatever is using it, so that when one value changes the other does too.
    // @Binding: as far as the button is concerned it’s just toggling a Boolean – it has no idea that something else is monitoring that Boolean and acting upon changes
 
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
 
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient.init(gradient: Gradient.init(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct BindingView: View {
    
    @State private var rememberMe = false
    
    var body: some View {
        VStack {
            //  once the button was created it takes over control of the value: it toggles the isOn property between true or false internally to the button, but doesn’t pass that change back on to ContentView
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct BindingView_Previews: PreviewProvider {
    static var previews: some View {
        BindingView()
    }
}
