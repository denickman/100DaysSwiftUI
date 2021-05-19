//
//  TechProjectView.swift
//  WeSplit
//
//  Created by Denis Yaremenko on 5/16/21.
//

import SwiftUI

struct TechProjectView: View {
    
    @State private var useRedText: Bool = false
    
    let text1 = Text("Lava tala smanas")
    let text2 = Text("Chiao bella, come sta")
    
    var text3: some View {
        Text("Hasta la vista")
    }
        
    var body: some View {
        
        Text("BLUE LARGE \n MODIFIER")
            .largeBlue()
        
        Color.blue
            .frame(width: 400, height: 400)
            .watermark(with: "XXX Hacking with swift")
        
            VStack(spacing: 10) {
                CapsuleText(text: "Capsule View 1")
                    .foregroundColor(.orange)
                CapsuleText(text: "Capsule View 2")
                    .foregroundColor(.yellow)
            }

        GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
        } // the same
        
        GridStack(rows: 4, columns: 4) { row, col in
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        } // the same

        VStack {
            text1
                .modifier(Title()) // the same

            text2
                .titleStyle() // the same

            text3
                .foregroundColor(.gray)

            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)

          /*
            This is called an environment modifier, and is different from a regular modifier that is applied to a view.

            From a coding perspective these modifiers are used exactly the same way as regular modifiers. However, they behave subtly differently because if any of those child views override the same modifier, the child’s version takes priority.
            */

            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.yellow)
                .edgesIgnoringSafeArea(.all)

            Divider()

            Button("Hello World") {
                print(type(of: self.body))
                self.useRedText.toggle()
            }
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color.red)
            .foregroundColor(useRedText ? .green : .blue)

            Divider()

            Text("Hello World")
                .padding()
                .background(Color.red)
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.yellow)

            Divider()
        }
    }
}

struct TechProjectView_Previews: PreviewProvider {
    static var previews: some View {
        TechProjectView()
    }
}
