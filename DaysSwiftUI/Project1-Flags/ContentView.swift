//
//  ContentView.swift
//  WeSplit
//
//  Created by Denis Yaremenko on 5/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tapCount = 0
    @State private var name = ""
    @State private var selectedStudent = "Harry"
    
    @State private var isShowingAlert = false
    
    let students = ["Harry", "Hermione", "Pol Pots"]
    
    var body: some View {
        
        NavigationView {
  
            Form { // up to 10 similar simple UI Elements not more
                
                Button.init("Show Alert") {
                    self.isShowingAlert = true
                }
                .alert(isPresented: $isShowingAlert, content: {
                    Alert(title: Text("Alert"), message: Text("Alert Message"), dismissButton: .default(Text("Ok")))
                })
                
                Picker("Select student", selection: $selectedStudent) {
                    ForEach(0..<students.count) {
                        Text(students[$0])
                    }
                }
                
                VStack {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }

                Section {
                    TextField("Enter your name", text: $name) // every property has $ here means two-way binding
                    Text("Your name is \(name)") // here is without $ because we do not want to bind here
                }
                
                Section {
                    ForEach(0..<12) {
                        Text("Row \($0)")
                    }
                }
                
                Section { // up to 10
                    Text("1")
                    Text("1")
                    Text("1")
                    Text("1")
                    Text("1")
                    Text("1")
                }
                
                Section { // up to 10
                    Text("2")
                    Text("2")
                    Text("2")
                    Text("2")
                    Text("2")
                    Text("2")
                }
            }
            .navigationBarTitle("SwiftUI", displayMode: .inline)
            //            .navigationBarTitle("SwiftUI")
        }
        
        
        Button("Tap count \(tapCount)") {
            // cannot visible in navigationview
            self.tapCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
