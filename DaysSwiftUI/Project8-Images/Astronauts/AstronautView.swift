//
//  AstronautView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/25/21.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
       
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    /*
                     Layout priority lets us control how readily a view shrinks when space is limited, or expands when space is plentiful. All views have a layout priority of 0 by default, which means they each get equal chance to grow or shrink. We’re going to give our astronaut description a layout priority of 1, which is higher than the image’s 0, which means it will automatically take up all available space.
                     */
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
